# Top level definitions for script
# RoA2 AppData Location should be in C:\Users\[Your UserName]\AppData\Local,
# if your RoA2 installation differs, change the LOCAL_PATH variable
$script:LOCAL_PATH = $Env:LocalAppData
$script:CONFIG_PATH = Join-Path $LOCAL_PATH -ChildPath "Rivals2\Saved\Config\Windows"
$script:COPIED_FILES_DIR = Join-Path $PSScriptRoot -ChildPath "CopiedFiles"
$script:LAST_COPIED_CONFIG = Join-Path $COPIED_FILES_DIR -ChildPath "0_LAST_COPIED_CONFIG.txt"

$script:READ_ONLY_FILES = "Engine.ini", "Scalability.ini"
$script:DRIVE_TYPE = "SSD", "HDD"
$script:PC_TYPES = "16GB_VRAM", "12GB_VRAM", "08GB_VRAM", "06GB_VRAM"
[int]$ERROR = -1

function Verify-Config-Directory {
    if (Test-Path $CONFIG_PATH) {
        Write-Host "RoA2 Config Path exists, script will continue"
    }
    else {
        Write-Host "RoA2 Config Path does not exist, script will not continue"
        Start-Sleep -Seconds 2
        exit 1
    }
}

function Help-Message {
    Write-Host "This script assumes that steam is installed in the default location(s)"
    Write-Host "Linux: Steam is installed in $HOME"
    Write-Host "Windows: Steam is installed in Program Files (x86)"
    Write-Host "[NOTE] By default: Potato mod will not be installed by default, if you are interested in getting potato mod, run roa2_install_potato_mod.bat"
}

function Options-Message {
    Write-Host "`n==============================================================================="
    Write-Host "Configurations have been premade and are located in Scripts/"
    Write-Host "There are two types of configurations, one for SSD and one for HDD"
    Write-Host "Please answer the prompts below to apply the optimizations based on your system."
    Write-Host "===============================================================================`n"
}

function Generate-Last-Config() {
    param([string]$config)
    Write-Output $config > $script:LAST_COPIED_CONFIG
}

function copy_files() {
    Verify-Config-Directory
    Write-Host "Deleting files in $CONFIG_PATH"

    Remove-Item -Path $CONFIG_PATH\* -Recurse -Force

    Copy-Item -Path $COPIED_FILES_DIR\*.ini $CONFIG_PATH

    for ($i = 0; $i -lt $READ_ONLY_FILES.Count; $i++)
    {
        $Local:file_name = Join-Path $CONFIG_PATH -ChildPath $($READ_ONLY_FILES[$i])
        Write-Host "Setting $file_name to Read-Only"
        Set-ItemProperty -Path $file_name -Name IsReadOnly -Value $true
    }
}
    
function HDD-Setup() {
    param([string] $DRIVE_TYPE)
    Generate-Last-Config $DRIVE_TYPE

    $SCRIPT_LOCATION = Join-Path $PSScriptRoot -ChildPath "Scripts\$DRIVE_TYPE"
    Copy-Item -Path $SCRIPT_LOCATION\*.ini -Destination $COPIED_FILES_DIR
    copy_files
}

function SSD-Setup() {
    param([string] $DRIVE_TYPE, [string] $VRAM)
    Generate-Last-Config $DRIVE_TYPE/$VRAM

    $SCRIPT_LOCATION = Join-Path $PSScriptRoot -ChildPath "Scripts\$DRIVE_TYPE\$VRAM"
    Copy-Item -Path $SCRIPT_LOCATION\*.ini -Destination $COPIED_FILES_DIR
    copy_files
}

function Setup() {
    param([string] $DRIVE_TYPE, [string] $VRAM)

    if (Test-Path $COPIED_FILES_DIR) {
        Write-Debug "$COPIED_FILES_DIR exists. Copied configuration files will be stored here"
    }
    else {
        Write-Debug $COPIED_FILES_DIR does not exist. Creating directory.
        New-Item $COPIED_FILES_DIR -ItemType Directory
    }

    if ($DRIVE_TYPE -ceq "HDD") {
        HDD-Setup $DRIVE_TYPE
    }
    else {
        SSD-Setup $DRIVE_TYPE $VRAM
    }
}

function Get-Folder-Names-And-Start() {
    param( [int]$config)

    $BASE_FOLDER = ""
    $SUB_FOLDER = ""
    if ( $config -eq 1 ) {
        $BASE_FOLDER = $DRIVE_TYPE[0]
        $SUB_FOLDER = $PC_TYPES[0]
    }
    elseif ( $config -eq 2 ) {
        $BASE_FOLDER = $DRIVE_TYPE[0]
        $SUB_FOLDER = $PC_TYPES[1]
    }
    elseif ( $config -eq 3 ) {
        $BASE_FOLDER = $DRIVE_TYPE[0]
        $SUB_FOLDER = $PC_TYPES[2]
    }
    elseif ( $config -eq 4 ) {
        $BASE_FOLDER = $DRIVE_TYPE[0]
        $SUB_FOLDER = $PC_TYPES[3]
    }
    elseif ( $config -eq 5 ) {
        $BASE_FOLDER = $DRIVE_TYPE[1]
    }
    else {
        Write-Host "Not sure why how you hit this, re-run the script"
    }

    Write-Debug "Copying files from Scripts/$BASE_FOLDER/$SUB_FOLDER to $COPIED_FILES_DIR Directory"
    Setup $BASE_FOLDER $SUB_FOLDER
}

function VRAM-Prompt() {
    Write-Host "VRAM Options:"
    Write-Host "`t Type 1 if your GPU has 16 GB of VRAM"
    Write-Host "`t Type 2 if your GPU has 12 GB of VRAM"
    Write-Host "`t Type 3 if your GPU has 8 GB of VRAM"
    Write-Host "`t Type 4 if your GPU has 6 GB of VRAM"
    
    [int]$vram = Read-Host -Prompt "How much VRAM does your GPU have?"
    if ($vram -ge 1 -and $vram -le 4) {
        return $vram
    }
    return $ERROR
}

function Drive-Prompt() {
    [int]$drive_result = Read-Host -Prompt "Is RoA2 installed on your SSD or HDD? Type and press 1 if installed on an SSD, Type 2 if installed on a HDD"
    if (($drive_result -gt 0) -and ($drive_result -lt 3)) {
        return $drive_result
    }
    return $ERROR
}

function main() {
    Help-Message
    Options-Message

    $drive_result = Drive-Prompt
    if ($drive_result -eq $ERROR) {
        Write-Host "Not a valid option. Exiting program"
        Start-Sleep -Seconds 2
        exit 1
    }

    if ($drive_result -eq 2) {
        Get-Folder-Names-And-Start 5
    }
    else {
        $vram_result = VRAM-Prompt

        if ($vram_result -eq $ERROR) {
            Write-Host "Not a valid option. Exiting program"
            Start-Sleep -Seconds 2
            exit 1
        }
        Get-Folder-Names-And-Start $vram_result
    }
    
    Write-Host "`n==============================================================================="
    Write-Host "Read Zaqk_README.txt for more information on adjusting things as needed" -BackgroundColor Blue
    Write-Host "`nNeed to update your config files? Make changes to your .ini files in:"
    Write-Host "$COPIED_FILES_DIR" -ForegroundColor Yellow
    Write-Host "Run update_config.bat"
    Write-Host "===============================================================================`n"
    Pause
    exit
}

main
