@ECHO OFF & CD/D "%~dp1"

"C:\Program Files\ffmpeg\bin\ffmpeg.exe"  -i "%~dpn1.flv" -vcodec copy -acodec copy "%~dpn1.mp4"

pause

