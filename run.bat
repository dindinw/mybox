@echo off

set GOPATH=%~dp0
set PATH=%GOPATH%/bin;%PATH%
echo.
echo # Compile and Install MYBOX...

if x%1==x--no-rebuild goto norebuild
echo # Rebuilding packages and commands.
go install -a -v mybox
if errorlevel 1 goto fail
:norebuild
call go install -v mybox
if errorlevel 1 goto fail

echo.
echo # Testing MYBOX...
echo.
call go test -v mybox/provider
if errorlevel 1 goto fail

echo.
echo # Running MYBOX...
echo.
call mybox
if errorlevel 1 goto fail
echo.
echo ALL Done!
goto end
:fail
set EXIT_STATUS=1
:end
exit /b %EXIT_STATUS%