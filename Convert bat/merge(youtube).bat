@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI-2715-32\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -i "%~dpn1.m4a" -vcodec copy -acodec copy "%~dpn1_merged.mp4"

pause