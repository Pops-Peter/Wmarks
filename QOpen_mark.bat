@Echo off
setlocal ENABLEDELAYEDEXPANSION
type nul>C:\Marks\temp.txt
type nul>C:\Marks\tempnew.txt
set /a MCOUNT = 0
set /a JCOUNT = 0
set /P id=Find mark:
For /F "delims=;" %%G in ('findstr /E /i %id% "C:\Marks\marks.csv"') do (
find "%%G" C:\Marks\temp.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%G>>C:\Marks\temp.txt
    )
set /a MCOUNT= !MCOUNT! + 1
)
For /F "delims=;" %%J in ('findstr /E /i %id% "J:\program\Wmarks\Wmarks.csv"') do (
find "%%J" C:\Marks\temp.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%J>>C:\Marks\temp.txt
    )
set /a JCOUNT= !JCOUNT! + 1
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
IF %COUNT% EQU 2 (
IF %MCOUNT% GEQ 1 for /F "delims=;" %%G in ('findstr /E /i %id% "C:\Marks\marks.csv"') do (
set str2=%%G
goto :open
)
IF %JCOUNT% GEQ 1 for /F "delims=;" %%J in ('findstr /E /i %id% "J:\program\Wmarks\Wmarks.csv"') do (
set str2=%%J
goto :open
)
)
set /P tag2=Select file number or enter new mark:
IF %tag2% LEQ %count% (
echo OK!
set /a c= 0
for /F "delims=" %%a in (C:\Marks\temp.txt) do (
set /a c= !c! + 1 
IF !c! EQU %tag2% set str2=%%a%)
goto :open
) ELSE (
For /F "tokens=*" %%G in (C:\Marks\temp.txt) do (
set str1=%%G
for /F "delims=;" %%A in ('findstr /i /E %tag2% "C:\Marks\marks.csv"') do (
IF %%A EQU !str1! do (
find "%%A" C:\Marks\tempnew.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%A>>C:\Marks\tempnew.txt
    )
)
)
)
For /F "tokens=*" %%G in (C:\Marks\temp.txt) do (
set str1=%%G
for /F "delims=;" %%A in ('findstr /i /E %tag2% "J:\program\Wmarks\Wmarks.csv"') do (
IF %%A EQU !str1! do (
find "%%A" C:\Marks\tempnew.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%A>>C:\Marks\tempnew.txt
    )
)
)
)
xcopy C:\Marks\tempnew.txt C:\Marks\temp.txt /y
)
goto :show
:open
@echo !str2!
del C:\Marks\tempnew.txt
del "C:\Marks\temp.txt"
start "" "!str2!"
:end