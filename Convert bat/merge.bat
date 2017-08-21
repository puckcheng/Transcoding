@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -r 59.94 -i "%~dpn1_pass2.h264" -i "%~dpn1%~x1" -vcodec copy -acodec copy "%~dpn1_merged.mp4"

pause