@ECHO OFF & CD/D "%~dp0"
IF "%~1"=="" GOTO STOP

:INPUT
set /p a1=请输入开始时间（秒）：
set /p a2=请输入结束时间（秒）：
IF "%a1%" LSS "%a2%" (IF "%a1%" GEQ "0" GOTO CUT) else ECHO 参数错误请重新输入！
GOTO INPUT

:CUT
set /a "hr1=a1/3600"
set /a "min1=(a1%%3600)/60+100"
set /a "sec1=a1%%60+100" 
set /a "hr2=a2/3600"
set /a "min2=(a2%%3600)/60+100"
set /a "sec2=a2%%60+100" 
set   min1=%min1:~-2%&set sec1=%sec1:~-2%
set   min2=%min2:~-2%&set sec2=%sec2:~-2%

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe"  -i "%~1" -vcodec copy -acodec copy -ss %hr1%:%min1%:%sec1% -to %hr2%:%min2%:%sec2% "%~dpn1_cuted%~x1"

:STOP
pause