#!/bin/bash

PATH_TO_STEAM_APPS=~/.steam/steam/steamapps
PATH_TO_STEAM_CONFIG=$PATH_TO_STEAM_APPS/compatdata/2217000/pfx/drive_c/users/steamuser/AppData/Local/Rivals2/Saved/Config/Windows
CopiedFilesDir=$(pwd)/CopiedFiles

declare -a READ_ONLY_FILES=("Engine.ini" "Scalability.ini")
echo "Deleting old config files in $PATH_TO_STEAM_CONFIG"
rm -f $PATH_TO_STEAM_CONFIG/*

cp "$CopiedFilesDir"/*.ini $PATH_TO_STEAM_CONFIG

echo "Setting Read Permissions only for "
for f in "${READ_ONLY_FILES[@]}"; do
  fn=$PATH_TO_STEAM_CONFIG/"$f"
  echo "$fn"
  chmod 444 $PATH_TO_STEAM_CONFIG/"$f"
done
