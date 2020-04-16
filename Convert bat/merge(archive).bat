@ECHO OFF 

"C:\Program Files (x86)\MeGUI-2715-32\tools\ffmpeg\ffmpeg.exe" -fflags +genpts -i "D:\Media\TEMP\%~n1_tmp.mp4" -i "%~dpn1%~x1" -map 0:v -map 1:a -vcodec copy  -acodec copy "%~dpn1_arc.mp4"

pause