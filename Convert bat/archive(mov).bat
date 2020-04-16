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
type list.tmp | findstr /e .MOV >> list.txt
del list.tmp

:PART
FOR /F %%g in (list.txt) DO (
set name=%%g
set name=!name:~0,8!

%mediainfo% "--Inform=Video;%%FrameCount%%" "%~dp1!name!.MOV" > "D:\Media\TEMP\frames.txt"

echo import vapoursynth as vs > "!name!.vpy"
echo import sys >> "!name!.vpy"
echo core=vs.get_core(accept_lowercase=True,threads=1^) >> "!name!.vpy"
echo core.max_cache_size=8000 >> "!name!.vpy"
echo source=r'%~dp1!name!.MOV' >> "!name!.vpy"
echo src=core.lsmas.LWLibavSource(source,threads=1^) >> "!name!.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0^) >> "!name!.vpy"
echo src.set_output(^) >> "!name!.vpy"

call :DoEncode !name!
)
ENDLOCAL

Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)
Echo done^^!
goto EOF

:DoEncode

Echo Building File Index......

FOR /F %%i in (D:\Media\TEMP\frames.txt) DO set tframes=%%i

%vspipe% --y4m "%~1.vpy" - | %x265% ^
--y4m --preset slow --pools 14 --frame-threads 4 ^
--frames %tframes% --output-depth 10 --crf 18 ^
--qcomp 0.65 --merange 44 --aq-strength 0.8 ^
--range full --colorprim bt709 --transfer bt709 --colormatrix smpte170m ^
--output "D:\Media\TEMP\%~1.tmp" -

ping 127.0.0.1 -n 2 >nul

%ffmpeg% -fflags +genpts -i "D:\Media\TEMP\%~1.tmp" -i "%~1.MOV" -map 0:v -map 1:a -vcodec copy  -acodec copy "%~1_arc.mp4"

ping 127.0.0.1 -n 1 >nul

del "%~1.vpy"
del "%~1.MOV.lwi"
del "D:\Media\TEMP\frames.txt"
del "D:\Media\TEMP\%~1.tmp"
cls

EXIT /B

:EOF
pause


