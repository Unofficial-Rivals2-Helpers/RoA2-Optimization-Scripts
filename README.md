# RoA2-Optimization-Scripts
Scripts to optimize Rivals of Aether 2 on low-mid-end PCs and existing handhelds

# NOTE 1: I AM NOT THE OWNER/DEVELOPER OF THESE SCRIPTS/MODS. ALL CREDIT GOES TO ZAQK AND RNG_SSB
# NOTE 2: THE LINUX SCRIPT IS FURTHER DEVELOPED THAN THE WINDOWS SCRIPT. THE WINDOWS SCRIPT INSTALLS THE FILES DIRECTLY FROM ZAQK'S GOOGLE DRIVE.

## Overview
Currently, there is an optimization script provided by zaqk that is available on youtube that can improve overall performance.

In addition, there is a potato mod that exists on gamebanana that also aids with improving performance as well.

In order to reduce the amount of manual steps (ie. going through directories and setting up file permissions, etc.), scripts are provided for both Linux and Windows that removes the manual steps and will automatically copy files over.

### Main Scripts to Run:
#### Windows
- `roa2_config_setup.bat`
    - This runs the powershell script (`roa2_config_setup.ps1`).
- `roa2_config_setup.ps1`
    - This is the "core". This prompts the user based on specific system requirements (eg. Has RoA2 been installed on an HDD or SSD?), generates the CopiedFiles/ directory which copies the appropriate configuration files from Scripts/ and then to the RoA2 Config directory.

#### Linux
- `roa2_config_setup.sh`
    - This is the "core". This prompts the user based on specific system requirements (eg. Has RoA2 been installed on an HDD or SSD?), generates the CopiedFiles/ directory which copies the appropriate configuration files from Scripts/ and then to the RoA2 Config directory.

### Optional Scripts:
#### Windows
- `roa2_install_potato_mod.bat`
    - This will automatically download the potatomod from gamebanana, unzip the file and place the .pak file in your Rivals 2 Paks directory.
- `update_config.bat`
    - This is for users that want to tweak their configuration file without having to manually toggle Read-Only for their Engine.ini or Scalability.ini files. 

#### Linux 
- `roa2_install_potato_mod.sh`
    - This will automatically download the potatomod from gamebanana, unzip the file and place the .pak file in your Rivals 2 Paks directory.
- `update_config.sh`
    - This is for users that want to tweak their configuration file without having to manually toggle Read-Only for their Engine.ini or Scalability.ini files. 

## Requirements
### Windows
1. [Required] Powershell (This should already be preinstalled with Windows 10+)

### Linux
1. [Optional] Terminal

## Running the Main Script for the first time:
1. Download a zip of this repository
1. Navigate to the location of the extracted directory.
1. Follow steps based on OS below

### Windows (GUI)
**For most regular windows users, follow this step.**
1. Double click `roa2_config_setup.bat`
1. Read and answer the prompts as necessary

### Windows (Powershell Terminal)
1. Run `.\roa2_config_setup.ps1` in your powershell terminal
1. Read and answer the prompts as necessary

### Linux (GUI)
1. Right click `./roa2_config_setup.sh`
1. Select `Run as a program`
1. Read and answer the prompts as necessary

### Linux (Terminal)
1. Run the following command in terminal:
> `./roa2_config_setup.sh`
1. Read and answer the prompts as necessary

## Installing Potato Mod
### Windows:
1. Run `roa2_install_potato_mod.bat`

### Linux (GUI)
1. Right click `roa2_install_potato_mod.sh` 
1. Select `Run as a program`

### Linux (Terminal)
1. Run `./roa2_install_potato_mod.sh`

## Making updates to the configuration file
### Requirements
1. Steps from [here](#running-the-main-script-for-the-first-time) has been performed.

### Usage
1. Navigate to `[RoA2-Optimization-Scripts Directory]/CopiedFiles`
1. Update any of the .ini files.

#### Windows
1. Run `update-config.bat`

#### Linux GUI
1. Right click `update-config.sh`
1. Select `Run as a program`

#### Linux (Terminal)
1. Run `update-config.sh`

## Troubleshooting:

### Windows:
1. I'm getting the following error:
> `.\roa2_config_setup.ps1 : File C:\Users\zab0\Documents\RoA2-Optimization-Scripts\roa2_config_setup.ps1 cannot be loaded because running scripts is disabled on this system. `

Answer: To fix this issue, run `roa2_config_setup.bat` instead.

Reason: Due to how Windows Security Policies are, they do not allow users to run powershell scripts unless the CurrentUser Execution Policy is set to the appropriate field. Running `roa2_config_setup.bat` bypasses the policy temporarily to run the powershell script.

### Linux:
1. I can't run the shell file as an executable.

Answer: (Terminal) Run the following command: `chmod +x roa2_config_setup.sh`

Answer: (GUI) Right click `roa2_config_setup.sh`, go to properties and make the 

Reason: `roa2_config_setup.sh` may not be seen as executable after being downloaded from a release build.

### Videos:
This is a list of videos that I'm keeping logged here to showcase the changes in terms of stability and performance:

https://www.youtube.com/watch?v=ty253O2D6_Y

### License:
I honestly don't care, but go to your locals and give zaqk their thanks.

