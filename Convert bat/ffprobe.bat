@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files\Transcode\ffmpeg\ffprobe.exe" -show_streams "%~dpn1%~x1"

pause