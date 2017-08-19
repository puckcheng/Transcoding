@ECHO OFF & CD/D "%~dp1"
:ReMux1
IF "%~1"=="" GOTO :STOP
IF /I "%~x1"==".flv" (Set Ext=.mp4) ELSE (GOTO :STOP) 
::Set Ext=.mp4
"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe"  -i "%~dpn1.flv" -vcodec copy -acodec copy "%~dpn1%Ext%"
::IF %ERRORLEVEL% == 0 (Del "%~1")
SHIFT /1
GOTO :ReMux1
:STOP
pause

