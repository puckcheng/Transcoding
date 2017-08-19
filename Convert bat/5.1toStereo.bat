@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -vn -f wav -acodec pcm_f32le -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" - | "C:\Program Files (x86)\MeGUI_2715_x64\tools\fdkaac\fdkaac.exe" --ignorelength -m 0 -b 192 -w 44100 -p 2 - -o "%~dpn1.m4a"

pause