@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x64\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -vcodec copy -an "%~dpn1_vid%~x1"

pause