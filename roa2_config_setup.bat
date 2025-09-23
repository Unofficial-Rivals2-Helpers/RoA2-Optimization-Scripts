@echo off

if "%~1" == "" (
  call :options_msg
  goto :user_input
) 
if "%~1" == "help" (
  call :help_msg
  pause
  goto :done
)
if "%~1" == "options" (
  call :options_msg
  pause
  goto :done
)

:user_input
set /p i=
SET "var="&for /f "delims=0123456789" %%i in ("%1") do set var=%%i
if not defined var (goto :verify_directory) else (
  echo Please provide a valid option [1-6].
  goto :help_msg
)

:verify_directory
IF EXIST "%PATH_TO_STEAM_CONFIG%" (
  echo Steam directory has been found, script will continue.
  GOTO :main
) ELSE (
  echo Steam directory not found.
  goto :done
)

:options_msg
  echo This script assumes that steam is installed in the default location(s)
  echo Linux: Steam is installed in $HOME
  echo Windows: Steam is installed in Program Files (x86)
  echo By default: Potato mod will be installed, so either comment it out in this bash script or hold your peace."
  echo Running the script:
  echo  Execute ./roa2_config_setup.sh [Value]
  echo  Example: ./roa2_config_setup.sh 2\n"
  echo Run ./roa2_config_setup.sh options to see all available configurations
}

:help_msg
@echo Configurations have been premade and are located in Scripts/
@echo There are two folders, one including modified network settings and one without
@echo Options 1-3:
@echo 	./roa2_config_setup 1
@echo 	This will by default setup the GameUserSettings.ini and Engine.ini with network settings and assumes you have a "good" PC.
@echo 	./roa2_config_setup 2
@echo 	This will by default setup the GameUserSettings.ini and Engine.ini with network settings and assumes you have a mid PC.
@echo 	./roa2_config_setup 3
@echo 	This will by default setup the GameUserSettings.ini and Engine.ini with network settings and assumes you have a low-end PC.
@echo Options 4-6:
@echo 	./roa2_config_setup 4
@echo 	This will by default setup the GameUserSettings.ini and Engine.ini without network settings and assumes you have a "good" PC.
@echo 	./roa2_config_setup 5
@echo 	This will by default setup the GameUserSettings.ini and Engine.ini without network settings and assumes you have a "mid" PC.
@echo 	./roa2_config_setup 6
@echo 	This will by default setup the GameUserSettings.ini and Engine.ini without network settings and assumes you have a "low-end" PC.

:main
REM This is ugly as hell, but we ball -- can't figure out how to index into an set properly.
SETLOCAL enabledelayedexpansion
set NETWORK_TYPE[0]=NetworkSettingsApplied
set NETWORK_TYPE[1]=NoNetworkSettingsApplied
set PC_TYPES[0]=Default
set PC_TYPES[1]=Mid
set PC_TYPES[2]=Low

set net_type=""
set pc_type=""

if %i% == 1 (
  set net_type=!NETWORK_TYPE[0]!
  set pc_type=!PC_TYPES[0]!
)
if %i% == 2 (
  set net_type=!NETWORK_TYPE[0]!
  set pc_type=!PC_TYPES[1]!
)
if %i% == 3 (
  set net_type=!NETWORK_TYPE[0]!
  set pc_type=!PC_TYPES[2]!
)
if %i% == 4 (
  set net_type=!NETWORK_TYPE[1]!
  set pc_type=!PC_TYPES[0]!
)
if %i% == 5 (
  set net_type=!NETWORK_TYPE[1]!
  set pc_type=!PC_TYPES[1]!
)
if %i% == 6 (
  set net_type=!NETWORK_TYPE[1]!
  set pc_type=!PC_TYPES[2]!
)

set SELECTED_DIR=%cd%\Scripts\%net_type%\%pc_type%

set PATH_TO_STEAM_CONFIG=%appdata%\..\Local\Rivals2\Saved\Config\Windows

REM Copy files from specified option to Steam Config
xcopy /r %SELECTED_DIR% %PATH_TO_STEAM_CONFIG%
attrib +r %PATH_TO_STEAM_CONFIG%\*


:potato_mod_install
set PATH_TO_STEAM_APPS=%programfiles(x86)%\Steam\steamapps

@echo "Installation of Potato Mod"

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
