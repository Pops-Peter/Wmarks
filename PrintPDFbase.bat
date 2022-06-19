@echo off
setlocal ENABLEDELAYEDEXPANSION
set @pdfs="" "" ""
"C:\pdf995\res\utilities\pdfcombine.exe" %@pdfs% "C:\result.pdf"
start C:\result.pdf
:end
