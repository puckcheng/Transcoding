@ECHO OFF & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -itsoffset 1.13 -i "%~dpn1%~x1" -map 1:v -map 0:a -vcodec copy -acodec copy "%~dpn1_delayed%~x1"

pause
