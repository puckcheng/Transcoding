@ECHO OFF & CD/D "%~dp1"

set /p f="Convert to? "

"C:\Program Files\Transcode\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -strict -2 -vn -acodec %f% -ar 48000 -ab 192k -ac 2 "%~dpn1.%f%"

pause