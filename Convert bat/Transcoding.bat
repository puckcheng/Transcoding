@ECHO OFF


set /p sframe="Start Frame:"
set num=%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
rem static start
rem Required programs
set vspipe="C:\Program Files (x86)\VapourSynth\core64\vspipe.exe"
set mediainfo="C:\Program Files (x86)\MediainfoCLI\MediaInfo.exe"
set x265="C:\Program Files (x86)\MeGUI-2715-32\tools\x265\x64\x265.exe"
rem static end
if "%sframe%"=="0" (set dash=#) else set dash=

:DoEncode
SETLOCAL
%mediainfo% "--Inform=Video;%%FrameCount%%" "%~dpn1%~x1" > "D:\Media\TEMP\frames.txt"
FOR /F %%i in (D:\Media\TEMP\frames.txt) do set tframe=%%i

set /a "eframe=%tframe%-1"
set /a "tframe=%eframe%-%sframe%+1"

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=7) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo #src=core.ffms2.Source(Source) >> "%~dpn1.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo #SM=haf.SMDegrain(src,tr=2,thSAD=300,contrasharp=True,chroma=False,plane=0) >> "%~dpn1.vpy"
echo %dash%src=core.std.Trim(src,%sframe%,%eframe%) >> "%~dpn1.vpy"
echo BM3D=mvf.BM3D(src,sigma=[10,0,0],radius1=0,profile1="lc") >> "%~dpn1.vpy"
echo BM3D.set_output() >> "%~dpn1.vpy"

Echo Building File Index......

%vspipe% --y4m "%~dpn1.vpy" - | %x265% ^
--y4m --preset slow --frame-threads 7 ^
--frames %tframe% -D 10 --crf 20 ^
--qcomp 0.65 --merange 44 --aq-strength 0.8 ^
--deblock=1:0 --output "D:\Media\TEMP\%~n1_%num%.mkv" -
ENDLOCAL

Echo  
::ping 127.0.0.1 -n 1 >nul
::mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

Echo Press [Space] to delete TEMP files
pause
del "%~dpn1.vpy"
del "%~dpn1%~x1.lwi"
del "%~dpn1%~x1.ffindex"
del "D:\Media\TEMP\frames.txt"
Echo done!
pause