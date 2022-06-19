@echo off
if "%1"=="" goto error
echo File found at:
echo %*
set /P id=Enter Wmark:
:Wmark
echo %*; %id%>>J:\program\Wmarks\Wmarks.csv
set /P id=Enter Another Xmark or Type "x" to exit:
if "%id%"=="x" goto :end
if "%id%"=="X" goto :end
goto :Wmark
:error
echo file name is not readable.
pause
:end