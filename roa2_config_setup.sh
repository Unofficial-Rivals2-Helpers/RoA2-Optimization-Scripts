#!/bin/bash
# Thanks to zaqk for the optimization guide and the developer of the PotatoMod

# Top level definitions
PATH_TO_STEAM_APPS=~/.steam/steam/steamapps
PATH_TO_STEAM_CONFIG=$PATH_TO_STEAM_APPS/compatdata/2217000/pfx/drive_c/users/steamuser/AppData/Local/Rivals2/Saved/Config/Windows
CopiedFilesDir=$(pwd)/CopiedFiles
LastCopiedConfig=$CopiedFilesDir/0_LAST_COPIED_CONFIG.txt

declare -a READ_ONLY_FILES=("Engine.ini" "Scalability.ini")

DRIVE_TYPE=("SSD" "HDD")
PC_TYPES=("16GB_VRAM" "12GB_VRAM" "08GB_VRAM" "06GB_VRAM")


verify_steam_directory() {
  if [ -d "$1" ]; then
    echo "Steam directory has been found, script will continue."
  else
    echo "Steam directory does not exist in default directory, modify this script to point to the correct path."
    exit
  fi
}


help_msg() {
  echo "This script assumes that steam is installed in the default location(s)"
  echo "Linux: Steam is installed in $HOME"
  echo "Windows: Steam is installed in Program Files (x86)"
  echo "[NOTE] By default: Potato mod will not be installed by default, if you are interested in getting potato mod, run roa2_install_potato_mod.bat"
}


options_msg() {
    printf "\n===============================================================================\n"
    printf "Configurations have been premade and are located in Scripts/\n"
    printf "There are two types of configurations, one for SSD and one for HDD\n"
    printf "Please answer the prompts below to apply the optimizations based on your system.\n"
    printf "===============================================================================\n"
}


copy_files() {
  verify_steam_directory $PATH_TO_STEAM_APPS

  echo "Deleting old config files in $PATH_TO_STEAM_CONFIG"
  rm -f $PATH_TO_STEAM_CONFIG/*

  cp "$CopiedFilesDir"/*.ini $PATH_TO_STEAM_CONFIG

  echo "Setting Read Permissions only for "
  for f in "${READ_ONLY_FILES[@]}"; do
    local fn=$PATH_TO_STEAM_CONFIG/"$f"
    echo "$fn"
    chmod 444 $PATH_TO_STEAM_CONFIG/"$f"
  done
}


generate_last_config_text() {
  local cfg=$1
  echo "$cfg" > "$LastCopiedConfig"
}


hdd_setup() {
  # Create empty file with last type of 
  # configuration copied to RoA2 Configuration Directory
  local BASE_FOLDER=$1
  generate_last_config_text "$BASE_FOLDER"

  local CURRENT_DIR
  CURRENT_DIR=$(pwd)

  local SCRIPT_LOCATION
  SCRIPT_LOCATION=$CURRENT_DIR/Scripts/$BASE_FOLDER

  cp "$SCRIPT_LOCATION"/*.ini "$CopiedFilesDir"
  copy_files
}


ssd_setup() {
  local BASE_FOLDER=$1
  local SUB_FOLDER=$2

  generate_last_config_text "$BASE_FOLDER"/"$SUB_FOLDER"
  local CURRENT_DIR
  CURRENT_DIR=$(pwd)

  local SCRIPT_LOCATION
  SCRIPT_LOCATION=$CURRENT_DIR/Scripts/$BASE_FOLDER/$SUB_FOLDER

  cp "$SCRIPT_LOCATION"/*.ini "$CopiedFilesDir"
  copy_files
}


setup() {
  # Handle possible edge case
  if [[ $# -eq 0 ]]; then
    printf "Error" 
  fi

  local BASE_FOLDER
  BASE_FOLDER=$1

  # Check if the LastCopiedDirectory exists
  if [ -d "$CopiedFilesDir" ]; then
    echo "$CopiedFilesDir directory exists, copied configurations files will be copied there"
  else
    echo "$CopiedFilesDir directory does not exist, creating directory"
    mkdir "$CopiedFilesDir"
  fi

  local drive_install=${1}
  if [[ ${drive_install} == "HDD" ]]; then
    hdd_setup "$BASE_FOLDER"
  else
    local SUB_FOLDER
    SUB_FOLDER=$2
    ssd_setup "$BASE_FOLDER" "$SUB_FOLDER"
  fi
}


get_folder_names_and_start() {
  local BASE_FOLDER
  local SUB_FOLDER
  if [[ $1 -eq 1 ]]; then
    BASE_FOLDER=${DRIVE_TYPE[0]}
    SUB_FOLDER=${PC_TYPES[0]}
  elif [[ $1 -eq 2 ]]; then
    BASE_FOLDER=${DRIVE_TYPE[0]}
    SUB_FOLDER=${PC_TYPES[1]}
  elif [[ $1 -eq 3 ]]; then
    BASE_FOLDER=${DRIVE_TYPE[0]}
    SUB_FOLDER=${PC_TYPES[2]}
  elif [[ $1 -eq 4 ]]; then 
    BASE_FOLDER=${DRIVE_TYPE[0]}
    SUB_FOLDER=${PC_TYPES[3]}
  elif [[ $1 -eq 5 ]]; then
    BASE_FOLDER=${DRIVE_TYPE[1]}
    SUB_FOLDER=""
  else
    echo -e "Invalid Argument provided. Exiting"
    sleep 2
    exit
  fi
  echo -e "Copying files from Scripts/$BASE_FOLDER/$SUB_FOLDER to Rivals Config Directory"

  setup "$BASE_FOLDER" "$SUB_FOLDER"
}


drive_prompt() {
  local drive
  read -r drive
  if [[ ${drive} == "1" ]]; then
    echo 1
  elif [[ ${drive} == "2" ]]; then
    echo 2
  else
    echo 255
  fi
}


vram_prompt() {
  local vram
  read -r vram
  if [[ ${vram} == "1" ]]; then
    echo 1
  elif [[ ${vram} == "2" ]]; then
    echo 2
  elif [[ ${vram} == "3" ]]; then
    echo 3
  elif [[ ${vram} == "4" ]]; then
    echo 2
  else
    echo 255
  fi
}

nominal_exit_msg()
{
  local YELLOW
  YELLOW='\033[0;33m'
  local NC
  NC='\033[0m'
  local BLUE
  BLUE='\033[34m'

  printf "\n===============================================================================\n"
  printf "${BLUE}%s${NC}" "Zaqk_README.txt for more information on adjusting things as needed"
  printf "\nNeed to update your config files? Make changes to your .ini files in:\n"
  printf "${YELLOW}%s${NC}\n" "$CopiedFilesDir"
  printf "Run update_config.bat\n"
  printf "===============================================================================\n"
  sleep 5
}

main() {
  if [[ $# -eq 0 || $1 == "help" ]]; then
    # If user decides to run this executable without arguments or via double click
    help_msg
    options_msg

    echo "Is RoA2 installed on your SSD or HDD? Type and press 1 if installed on an SSD, Type 2 if installed on a HDD"
    # local drive_result
    local drive_result
    drive_result=$(drive_prompt)
    if [[ $drive_result -eq 255 ]]; then
      echo "Not a valid option. Exiting program."
      sleep 2
      exit
    fi

    local vram_result
    if [[ $drive_result -eq 2 ]]; then
      get_folder_names_and_start 5
    elif [[ $drive_result -eq 1 ]]; then
      printf "How much VRAM does your GPU have?\n"
      printf "\t Type 1 if your GPU has 16 GB of VRAM\n"
      printf "\t Type 2 if your GPU has 12 GB of VRAM\n"
      printf "\t Type 3 if your GPU has 8 GB of VRAM\n"
      printf "\t Type 4 if your GPU has 6 GB of VRAM\n"

      vram_result=$(vram_prompt)
      get_folder_names_and_start "$vram_result"
      nominal_exit_msg
    fi

    exit
  elif [[ $1 == options ]]; then
    options_msg
    exit
  else
    get_folder_names_and_start "$1"
  fi
}

main "$@" 
