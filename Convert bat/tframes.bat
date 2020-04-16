@ECHO OFF
set mediainfo="C:\Program Files (x86)\MediainfoCLI\MediaInfo.exe"

%mediainfo% "--Inform=Video;%%FrameCount%%" "%~dpn1%~x1" > "D:\Media\TEMP\frames.txt"
FOR /F %%i in (D:\Media\TEMP\frames.txt) do set tframe=%%i

echo Total Frame Count: %tframe%

pause