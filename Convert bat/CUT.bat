@ECHO OFF & CD/D "%~dp0"
IF "%~1"=="" GOTO STOP

:INPUT
set /p a1=�����뿪ʼʱ�䣨�룩��
set /p a2=����������ʱ�䣨�룩��
IF "%a1%" LSS "%a2%" (IF "%a1%" GEQ "0" GOTO CUT) else ECHO �����������������룡
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
