@echo off
if "%1"=="" goto error
echo File found at:
echo %*
set /P id=Enter Mark:
:mark
echo %*; %id%>>C:\Marks\Marks.csv
set /P id=Enter Another Mark or Type "x" to exit:
if "%id%"=="x" goto :end
goto :mark
:error
echo file name is not readable.
pause
:end