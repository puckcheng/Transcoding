@ECHO OFF & CD/D "%~dp1"

del "list.txt"

SETLOCAL ENABLEDELAYEDEXPANSION
SETLOCAL

Set "Pattern= "
Set "Replace=_"

For %%a in (*.flac) Do (
    Set "File=%%~a"
    Ren "%%a" "!File:%Pattern%=%Replace%!"
)


dir /b > list.tmp
type list.tmp | findstr /e .flac >> list.txt
del list.tmp


FOR /F %%g in (list.txt) DO (
set name=%%g
set name=!name:~0,-5!
call :DoEncode !name!
)
ENDLOCAL

del "list.txt"
Echo  
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)
Echo done^^!
goto EOF

:DoEncode

"C:\Program Files (x86)\MeGUI-2715-32\tools\ffmpeg\ffmpeg.exe" -i "%name%.flac" "%name%.wav"

ping 127.0.0.1 -n 2 >nul

del "%name%.flac"

cls

EXIT /B

:EOF
pause