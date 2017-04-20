@ECHO OFF & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1.mp4" -acodec copy -vn "%~dpn1.wav"

pause