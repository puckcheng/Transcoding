@ECHO OFF & CD /D "%~dp1"

rem static start
rem Required programs
set vspipe="C:\Program Files (x86)\VapourSynth\core64\vspipe.exe"
set mediainfo="C:\Program Files (x86)\MediainfoCLI\MediaInfo.exe"
set x265="C:\Program Files (x86)\MeGUI\tools\x265\x64\x265.exe"
set ffmpeg="C:\Program Files (x86)\MeGUI\tools\ffmpeg\ffmpeg.exe"
rem static end

SETLOCAL ENABLEDELAYEDEXPANSION
SETLOCAL

set /P list="Generate list.txt?  "
if "%list%"=="y" goto ALL 
if "%list%"=="n" goto PART
goto EOF

:ALL
dir /b > list.tmp
type list.tmp | findstr /e .mp4 >> list.txt
del list.tmp

:PART
FOR /F %%g in (list.txt) DO (
set name=%%g

%mediainfo% "--Inform=Video;%%FrameCount%%" "%~dp1!name!" > "D:\TEMP\frames.txt"

echo import vapoursynth as vs > "!name!.vpy"
echo import sys >> "!name!.vpy"
echo core=vs.get_core(threads=4^) >> "!name!.vpy"
echo core.max_cache_size=8000 >> "!name!.vpy"
echo source=r'%~dp1!name!' >> "!name!.vpy"
echo src=core.ffms2.Source(source,threads=1^) >> "!name!.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0^) >> "!name!.vpy"
echo src=core.std.AssumeFPS(src,fpsnum=24000,fpsden=1001^) >> "!name!.vpy"
echo src.set_output(^) >> "!name!.vpy"

ping 127.0.0.1 -n 3 >nul
call :DoEncode !name!
)
ENDLOCAL

Echo  
del "D:\TEMP\list.txt"
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)
Echo done^^!
goto EOF

:DoEncode

Echo Building File Index......

FOR /F %%i in (D:\TEMP\frames.txt) DO set tframes=%%i

%vspipe% --y4m "%name%.vpy" - | %x265% ^
--y4m --preset slow --pools 12 --frame-threads 4 ^
--frames %tframes% --crf 18 --output-depth 10 ^
--qcomp 0.65 --merange 44 --aq-strength 0.8 --keyint 1 ^
--range full --colorprim bt709 --transfer bt709 --colormatrix bt709 ^
--output "D:\TEMP\%name%.tmp" -

ping 127.0.0.1 -n 2 >nul

set name=%name:~0,8%

%ffmpeg% -fflags +genpts -i "D:\TEMP\%name%_arc.mp4.tmp" -i "%name%_arc.mp4" -map 0:v -map 1:a -vcodec copy  -acodec copy "%name%.mov"

ping 127.0.0.1 -n 1 >nul

del "%name%_arc.mp4.vpy"
del "%name%_arc.mp4.ffindex"
del "D:\TEMP\frames.txt"
del "D:\TEMP\%name%_arc.mp4.tmp"
cls

EXIT /B

:EOF
pause


