@echo off
rem This is a Windows wrapper for MYBOX
rem set root dir
set "SHARE_DIR=%~dp0\..\share"

rem save path now
set "MYBOX_PATH_SAVED=%PATH%"

rem Prepend msys bin to PATH, we can find bash
set "PATH=%SHARE_DIR%\msysgit\bin;%PATH%"

rem Run MYBOX.sh ...
"%SHARE_DIR%\..\share\msysgit\bin\bash.exe" "%SHARE_DIR%/../bin/mybox.sh" %*

rem Store the exit status
set "MYBOX_EXIT_STATUS=%ERRORLEVEL%"

rem Restore path
set "PATH=%MYBOX_PATH_SAVED%"