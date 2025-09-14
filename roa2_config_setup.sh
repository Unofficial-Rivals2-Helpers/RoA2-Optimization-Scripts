# Thanks to zaqk for the optimization guide and the developer of the PotatoMod
verify_directory() {
  if [ -d $1 ]; then
    echo "Steam directory exists"
  else
    echo "Steam directory does not exist in default directory, modify this script to point to the correct path."
    exit
  fi
}

PATH_TO_STEAM_APPS=~/.steam/steam/steamapps
PATH_TO_STEAM_CONFIG=$PATH_TO_STEAM_APPS/compatdata/2217000/pfx/drive_c/users/steamuser/AppData/Local/Rivals2/Saved/Config/Windows
verify_directory $PATH_TO_STEAM_APPS

# Installation of Configuration Files
ENGINE_INI_LINK="https://drive.google.com/uc?export=download&id=1esVP4uAT27lZUqgsknLx1VhK4WVbM8PD"
ENGINE_INI_PATH=$PATH_TO_STEAM_CONFIG/Engine.ini
wget -O $ENGINE_INI_PATH $ENGINE_INI_LINK
chmod 444 $ENGINE_INI_PATH

GAME_USER_SETTINGS_LINK="https://drive.google.com/uc?export=download&id=1LltGygLzacIOcH3V1WtuvHDebNGvMkMa"
GAME_USER_INI_PATH=$PATH_TO_STEAM_CONFIG/GameUserSettings.ini
wget -O $GAME_USER_INI_PATH $GAME_USER_SETTINGS_LINK
chmod 444 $GAME_USER_INI_PATH

# Installation of Potato Mod
PATH_TO_STEAM_LOCAL=$PATH_TO_STEAM_APPS/common/Rivals\ 2/Rivals2/Content/Paks
POTATO_MOD_PATH="$PATH_TO_STEAM_LOCAL"/potato.zip
cd "$PATH_TO_STEAM_LOCAL"
wget -O POTATO_MOD_PATH https://gamebanana.com/dl/1446017
unzip POTATO_MOD_PATH
rm POTATO_MOD_PATH

