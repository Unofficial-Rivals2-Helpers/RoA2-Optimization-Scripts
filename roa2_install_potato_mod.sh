PATH_TO_STEAM_APPS=~/.steam/steam/steamapps
# Installation of Potato Mod
PATH_TO_STEAM_LOCAL=$PATH_TO_STEAM_APPS/common/Rivals\ 2/Rivals2/Content/Paks
POTATO_MOD_PATH=$PATH_TO_STEAM_LOCAL/potato.zip
cd "$PATH_TO_STEAM_LOCAL" || exit
wget -O "$POTATO_MOD_PATH" https://gamebanana.com/dl/1446017
unzip "$POTATO_MOD_PATH"
rm "$POTATO_MOD_PATH"

