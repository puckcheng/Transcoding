@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -r 23.976 -i "%~dpn1%~x1" -vcodec copy -an "%~dpn1_merged.mp4"

pause