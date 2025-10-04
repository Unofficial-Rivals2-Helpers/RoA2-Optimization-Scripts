set PATH_TO_STEAM_APPS=%programfiles(x86)%\Steam\steamapps
set PATH_TO_STEAM_LOCAL=%PATH_TO_STEAM_APPS%\common\Rivals 2\Rivals2\Content\Paks
set POTATO_MOD_PATH=%PATH_TO_STEAM_LOCAL%
set POTATO_FILE_NAME=%POTATO_MOD_PATH%\potato.zip
curl -L "https://gamebanana.com/dl/1446017" -o "%POTATO_FILE_NAME%"
pushd .
cd %POTATO_MOD_PATH%
tar -xf "%POTATO_FILE_NAME%"
del "%POTATO_FILE_NAME%"
popd

:done
@echo Exiting script.
