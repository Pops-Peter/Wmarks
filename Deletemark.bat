@Echo off
setlocal ENABLEDELAYEDEXPANSION
type nul>C:\Marks\temp.txt
type nul>C:\Marks\templine.txt
type nul>C:\Marks\tempcsv.csv
set /P id=Find mark:
For /F "delims=;" %%G in ('findstr /E /i %id% "C:\Marks\Marks.csv"') do (
find "%%G" C:\Marks\temp.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%G>>C:\Marks\temp.txt
    )
)
:show
echo.
echo.
echo.
echo Files found:
set /a count = 1
For /F "tokens=*" %%a in (C:\Marks\temp.txt) do (
@echo !count!. %%a
set /a count= !count! + 1)
echo.
set /P tag2=Select file number, or enter second tag:
echo %tag2%
pause
IF %tag2% LEQ %count% (
echo OK!
set /a c= 0
for /F "delims=" %%a in (C:\Marks\temp.txt) do (
set /a c= !c! + 1 
IF !c! EQU %tag2% set str2=%%a%)
goto :remove
) ELSE (
For /F "tokens=*" %%G in (C:\Marks\temp.txt) do (
set str1=%%G
for /F "delims=;" %%A in ('findstr /i /E %tag2% "C:\Marks\Marks.csv"') do (
set str2=%%A 
IF !str2! EQU !str1! echo !str1!>>C:\Marks\tempnew.txt
)
)
xcopy C:\Marks\tempnew.txt C:\Marks\temp.txt /y
del C:\Marks\tempnew.txt
)
goto :show
:remove
echo %str2%; %ID%>>C:\Marks\templine.txt
For /F "tokens=*" %%a in (C:\Marks\Marks.csv) do (
find "%%a" C:\Marks\templine.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%a>>C:\Marks\tempcsv.csv
    )
)
del "C:\Marks\templine.txt"
xcopy C:\Marks\tempcsv.csv C:\Marks\Marks.csv /y
del "C:\Marks\tempcsv.csv"
del "C:\Marks\temp.txt"
:end