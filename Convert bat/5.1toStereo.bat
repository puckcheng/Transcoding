@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files (x86)\MeGUI\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -vn -f wav -acodec pcm_f32le -ar 48000 -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" - | "D:\Puckcheng\Github\fdkaac\fdkaac.exe" -m 0 -f 0 -b 192 -a 1 -o "%~dpn1_converted.m4a" -

pause