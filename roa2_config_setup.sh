# Thanks to zaqk for the optimization guide and the developer of the PotatoMod
verify_directory() {
  if [ -d $1 ]; then
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
  echo "By default: Potato mod will be installed, so either comment it out in this bash script or hold your peace."
  echo "Running the script:"
  echo -e "\tExecute ./roa2_config_setup.sh [Value]"
  echo -e "\tExample: ./roa2_config_setup.sh 2\n"
  echo "Run ./roa2_config_setup.sh options to see all available configurations"
}

options_msg() {
  echo "Configurations have been premade and are located in Scripts/"
  echo "There are two folders, one including modified network settings and one without"
  echo "Options 1-3:"
  echo -e "\t ./roa2_config_setup 1"
  echo -e "\t This will by default setup the GameUserSettings.ini and Engine.ini with network settings and assumes you have a \"good\" PC."
  echo -e "\t ./roa2_config_setup 2"
  echo -e "\t This will by default setup the GameUserSettings.ini and Engine.ini with network settings and assumes you have a \"mid\" PC."
  echo -e "\t ./roa2_config_setup 3"
  echo -e "\t This will by default setup the GameUserSettings.ini and Engine.ini with network settings and assumes you have a \"low-end\" PC."
  echo "Options 4-6:"
  echo -e "\t ./roa2_config_setup 4"
  echo -e "\t This will by default setup the GameUserSettings.ini and Engine.ini without network settings and assumes you have a \"good\" PC."
  echo -e "\t ./roa2_config_setup 5"
  echo -e "\t This will by default setup the GameUserSettings.ini and Engine.ini without network settings and assumes you have a \"mid\" PC."
  echo -e "\t ./roa2_config_setup 6"
  echo -e "\t This will by default setup the GameUserSettings.ini and Engine.ini without network settings and assumes you have a \"low-end\" PC."
}


NETWORK_TYPE=("NetworkSettingsApplied" "NoNetworkSettingsApplied")
PC_TYPES=("Default" "Mid" "Low" )
# Force arguments
if [[ $# -eq 0 || $1 == "help" ]]; then
  help_msg
elif [[ $1 == options ]]; then
  options_msg
elif [[ $1 -eq 1 ]]; then
  BASE_FOLDER=${NETWORK_TYPE[0]}
  SUB_FOLDER=${PC_TYPES[0]}
  echo -e "Installing Configuration File with Network Settings and RenderTargetPoolMin=4096 Streaming.PoolSize=0"
elif [[ $1 -eq 2 ]]; then
  BASE_FOLDER=${NETWORK_TYPE[0]}
  SUB_FOLDER=${PC_TYPES[1]}
  echo -e "Installing Configuration File with Network Settings and RenderTargetPoolMin=2048 Streaming.PoolSize=8000"
elif [[ $1 -eq 3 ]]; then
  BASE_FOLDER=${NETWORK_TYPE[0]}
  SUB_FOLDER=${PC_TYPES[2]}
  echo -e "Installing Configuration File with Network Settings and RenderTargetPoolMin=1024 Streaming.PoolSize=6000"
elif [[ $1 -eq 4 ]]; then
  BASE_FOLDER=${NETWORK_TYPE[1]}
  SUB_FOLDER=${PC_TYPES[0]}
  echo -e "Installing Configuration File without Network Settings and RenderTargetPoolMin=4096 Streaming.PoolSize=0"
elif [[ $1 -eq 5 ]]; then
  BASE_FOLDER=${NETWORK_TYPE[1]}
  SUB_FOLDER=${PC_TYPES[1]}
  echo -e "Installing Configuration File without Network Settings and RenderTargetPoolMin=2048 Streaming.PoolSize=8000"
elif [[ $1 -eq 6 ]]; then
  BASE_FOLDER=${NETWORK_TYPE[1]}
  SUB_FOLDER=${PC_TYPES[2]}
  echo -e "Installing Configuration File without Network Settings and RenderTargetPoolMin=1024 Streaming.PoolSize=6000"
fi

CURRENT_DIR=$(pwd)
SCRIPT_LOCATION=$CURRENT_DIR/Scripts/$BASE_FOLDER/$SUB_FOLDER

PATH_TO_STEAM_APPS=~/.steam/steam/steamapps
verify_directory $PATH_TO_STEAM_APPS

# Installation of Configuration Files
PATH_TO_STEAM_CONFIG=$PATH_TO_STEAM_APPS/compatdata/2217000/pfx/drive_c/users/steamuser/AppData/Local/Rivals2/Saved/Config/Windows
CONFIG_FILES=$SCRIPT_LOCATION
cp $CONFIG_FILES/* $PATH_TO_STEAM_CONFIG

# Installation of Potato Mod
PATH_TO_STEAM_LOCAL=$PATH_TO_STEAM_APPS/common/Rivals\ 2/Rivals2/Content/Paks
POTATO_MOD_PATH=$PATH_TO_STEAM_LOCAL/potato.zip
cd "$PATH_TO_STEAM_LOCAL"
wget -O "$POTATO_MOD_PATH" https://gamebanana.com/dl/1446017
unzip "$POTATO_MOD_PATH"
rm "$POTATO_MOD_PATH"

