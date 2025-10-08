@echo off
set LOCAL_PATH=%LocalAppData%
set CONFIG_PATH=%LOCAL_PATH%"\Rivals2\Saved\Config\Windows"

setlocal
set COPIED_DIR=%cd%\CopiedFiles

if exist %COPIED_DIR% (
    goto :copy_updated_files
) else (
    echo ==================================================================
    echo %COPIED_DIR% does not exist.
    echo:
    echo Run the roa2_config_setup.bat script first to generate this directory.
    echo Exiting.
    echo ==================================================================
    goto :exit_label
)

:copy_updated_files
setlocal enabledelayedexpansion
set READ_ONLY_FILES[0]="Engine.ini"
set READ_ONLY_FILES[1]="Scalability.ini"
set GameEngine="GameUserSettings.ini"

robocopy %COPIED_DIR% %CONFIG_PATH% !READ_ONLY_FILES[0]! !READ_ONLY_FILES[1]! /a+:R
robocopy %COPIED_DIR% %CONFIG_PATH% %GameEngine%

:exit_label
pause
