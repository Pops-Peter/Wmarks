@echo off
setlocal ENABLEDELAYEDEXPANSION

type nul>C:\Marks\ptemp.txt
set /P id=Find mark:
For /F "delims=;" %%G in ('findstr /E /i %id% "C:\Marks\marks.csv"') do (
find "%%G" C:\Marks\ptemp.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%G>>C:\Marks\ptemp.txt
    )
set /a MCOUNT= !MCOUNT! + 1
)
For /F "delims=;" %%J in ('findstr /E /i %id% "J:\program\Wmarks\Wmarks.csv"') do (
find "%%J" C:\Marks\ptemp.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%J>>C:\Marks\ptemp.txt
    )
set /a JCOUNT= !JCOUNT! + 1
)
:show
echo.
echo.
echo.
echo Files found:
set /a count = 1
For /F "tokens=*" %%a in (C:\Marks\ptemp.txt) do (
@echo !count!. %%a
set /a count= !count! + 1)
echo.
set /P tag2=Enter 1 to print or enter additional marks:
IF "%tag2%"=="1" (
for /F "delims=" %%a in (C:\Marks\ptemp.txt) do (
set @pdfs=!@pdfs! "%%a" 
)
goto :print
) ELSE (
type nul>C:\Marks\ptempnew.txt
For /F "tokens=*" %%G in (C:\Marks\ptemp.txt) do (
set str1=%%G
For /F "delims=;" %%A in ('findstr /i /E %tag2% "C:\Marks\marks.csv"') do (
IF %%A EQU !str1! do (
find "%%A" C:\Marks\ptempnew.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%A>>C:\Marks\ptempnew.txt
    )
)
)
)
For /F "tokens=*" %%G in (C:\Marks\ptemp.txt) do (
set str1=%%G
For /F "delims=;" %%A in ('findstr /i /E %tag2% "J:\program\Wmarks\Wmarks.csv"') do (
IF %%A EQU !str1! do (
find "%%A" C:\Marks\ptempnew.txt 1>nul
    if !errorlevel! NEQ 0 (
        echo %%A>>C:\Marks\ptempnew.txt
    )
)
)
)
xcopy C:\Marks\ptempnew.txt C:\Marks\ptemp.txt /y
del C:\Marks\ptempnew.txt
)
goto :show
:print
echo %@pdfs%
"C:\pdf995\res\utilities\pdfcombine.exe" %@pdfs% "C:\Marks\result.pdf"
del C:\Marks\ptemp.txt
start C:\Marks\result.pdf
:end
