@ECHO OFF  & CD/D "%~dp1"


"C:\Program Files\Transcode\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -vn -f wav -acodec pcm_f32le - | "C:\Program Files\Transcode\fdkaac\fdkaac.exe" --raw-channels 8 -m 0 -f 0 -a 1 -o "%~dpn1.m4a" -

pause