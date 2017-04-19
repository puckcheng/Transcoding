@ECHO OFF & CD/D "%~dp0"
:ReMux1
IF "%~1"=="" GOTO :STOP
IF /I "%~x1"==".mp4" (Set Ext=.flv) ELSE (GOTO :STOP) 
::Set Ext=.mp4
ffmpeg  -i "%~1" -vcodec copy -acodec copy "%~dpn1%Ext%"
::IF %ERRORLEVEL% == 0 (Del "%~1")
SHIFT /1
GOTO :ReMux1
:STOP
pause

