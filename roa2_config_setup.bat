@echo off

set PATH_TO_STEAM_CONFIG=%appdata%\..\Local\Rivals2\Saved\Config\Windows

set ENGINE_INI_LINK="https://drive.google.com/uc?export=download^&id=1esVP4uAT27lZUqgsknLx1VhK4WVbM8PD"
set ENGINE_INI_PATH=%PATH_TO_STEAM_CONFIG%\Engine.ini
curl -L %ENGINE_INI_LINK% -o %ENGINE_INI_PATH%
attrib +r %ENGINE_INI_PATH%

set GAME_USER_SETTINGS_LINK="https://drive.google.com/uc?export=download&id=1LltGygLzacIOcH3V1WtuvHDebNGvMkMa"
set GAME_USER_INI_PATH=%PATH_TO_STEAM_CONFIG%\GameUserSettings.ini
curl -L %GAME_USER_SETTINGS_LINK% -o %GAME_USER_INI_PATH%
attrib +r %GAME_USER_INI_PATH%

set PATH_TO_STEAM_APPS=%programfiles(x86)%\Steam\steamapps

echo "Installation of Potato Mod"

set PATH_TO_STEAM_LOCAL=%PATH_TO_STEAM_APPS%\common\Rivals 2\Rivals2\Content\Paks
set POTATO_MOD_PATH=%PATH_TO_STEAM_LOCAL%
set POTATO_FILE_NAME=%POTATO_MOD_PATH%\potato.zip
curl -L "https://gamebanana.com/dl/1446017" -o "%POTATO_FILE_NAME%"
pushd .
cd %POTATO_MOD_PATH%
tar -xf "%POTATO_FILE_NAME%"
del "%POTATO_FILE_NAME%"
popd
