@echo off
set LOCAL_PATH=%LocalAppData%
set CONFIG_PATH=%LOCAL_PATH%"\Rivals2\Saved\Config\Windows"

setlocal
set COPIED_DIR=%cd%\CopiedFiles

setlocal enabledelayedexpansion
set READ_ONLY_FILES[0]="Engine.ini"
set READ_ONLY_FILES[1]="Scalability.ini"
set GameEngine="GameUserSettings.ini"

robocopy %COPIED_DIR% %CONFIG_PATH% !READ_ONLY_FILES[0]! !READ_ONLY_FILES[1]! /a+:R
robocopy %COPIED_DIR% %CONFIG_PATH% %GameEngine%

pause
