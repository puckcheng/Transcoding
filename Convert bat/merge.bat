@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files\Transcode\ffmpeg\ffmpeg.exe" -r 60000/1001 -i "P1055056.MP4.tmp" -i "P1055056.MP4" -map 0:v -vcodec copy -map 1:a -c:a libopus -b:a 192K "merged.mp4"

pause