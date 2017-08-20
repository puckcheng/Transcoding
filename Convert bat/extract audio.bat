@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -filter:a "volume=0.3" -vn "%~dpn1.m4a"

pause