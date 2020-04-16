@ECHO OFF & CD/D "%~dp1"

"C:\Program Files\Transcode\ffmpeg\ffmpeg.exe"  -i "%~dpn1%~x1" -vcodec copy -acodec copy "%~dpn1.flv"

pause

