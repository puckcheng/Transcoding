@ECHO OFF  & CD/D "%~dp1"


"C:\Program Files (x86)\MeGUI_2715_x64\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -vn -f wav -acodec pcm_f32le -ar 48000 - | "C:\Program Files (x86)\MeGUI_2715_x64\tools\fdkaac\fdkaac.exe" -m 0 -f 0 -b 192 -a 1 -o "%~dpn1.m4a" -

pause