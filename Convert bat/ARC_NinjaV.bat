@ECHO OFF & CD /D "%~dp1"

SETLOCAL ENABLEDELAYEDEXPANSION

rem static start
rem Required programs
set vspipe="C:\Users\Puckcheng\AppData\Local\Programs\VapourSynth\core\vspipe.exe"
set mediainfo="C:\PROGRA~1\Transcode\mediainfo\MediaInfo.exe"
set x265="C:\PROGRA~1\Transcode\x265\x265-10.exe"
set mp4box="C:\PROGRA~1\GPAC\mp4box.exe"
set ffmpeg="C:\PROGRA~1\Transcode\ffmpeg\ffmpeg.exe"
set para="--Inform=Video;%%FrameCount%%"
rem static end


if exist list.txt (
			goto PART
) else (
			goto START
)


:START
set /P list="Generate file list ? (y/n) "
if "%list%"=="y" goto ALL 
if "%list%"=="n" goto PART
goto EOF


:ALL
for %%f in (*) do (
    if "%%~xf"==".MOV" echo %%f >> list.txt
)


:PART
for /f "delims=" %%i in (list.txt) do (
set name=%%i
set path="%~dp1!name!"
for /f "usebackq delims=" %%j in (`^"!mediainfo! !para! !path!^"`) do set frames=%%j
set name_s=!name:~7,14!


rem generate vapoursynth script
echo import vapoursynth as vs > "!name_s!.vpy"
echo import sys >> "!name_s!.vpy"
echo core=vs.get_core(threads=4^) >> "!name_s!.vpy"
echo core.max_cache_size=4000 >> "!name_s!.vpy"
echo source=r'%~dp1!name!.MOV' >> "!name!.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1^) >> "!name_s!.vpy"
echo src.set_output(^) >> "!name_s!.vpy"

ping 127.0.0.1 -n 3 >nul
call :DoEncode !name_s!
)

ENDLOCAL


Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)
Echo done^^!
goto EOF


:DoEncode

Echo Building File Index......

%vspipe% --y4m "%~1.vpy" - | %x265% ^
--y4m --preset slow --pools 8 --frame-threads 4 ^
--frames %frames% --output-depth 10 --crf 18 ^
--qcomp 0.65 --merange 44 --aq-strength 0.8 ^
--range full --colorprim bt709 --transfer bt709 --colormatrix bt709 ^
--output "%~1.hevc" -

ping 127.0.0.1 -n 2 >nul

%ffmpeg% -i "%~dpn1.MOV" -acodec copy "%~dpn1.WAV"

%mp4box% -add "%~dpn1.hevc" -add "%~dpn1.WAV" -new "ARC_%~1.mp4"

ping 127.0.0.1 -n 2 >nul



pause
del "%~1.vpy"
del "NINJAV_%~1.MOV.lwi"
del "%~1.hevc"
cls

EXIT /B

:EOF
pause


