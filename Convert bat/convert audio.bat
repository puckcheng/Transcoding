@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x64\tools\fdkaac\fdkaac.exe" -i "%~dpn1%~x1" -m 0 -b 192 -w 44100 -p 2 -o "%~dpn1.m4a"

pause