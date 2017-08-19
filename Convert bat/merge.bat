@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1_pass2.h264" -i "%~dpn1%~x1" -c copy "%~dpn1.mp4"

pause