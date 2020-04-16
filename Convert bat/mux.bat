@ECHO OFF  & CD/D "%~dp1"

"C:\Program Files\GPAC\mp4box.exe" -add "%~dpn1.h264:par=1:1:dur=273" -add "%~dpn1.m4a:sbr:dur=273" -new "%~dpn1_muxed.mp4"

pause