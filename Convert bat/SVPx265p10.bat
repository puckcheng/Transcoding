@ECHO OFF & CD /D "%~dp1"
chcp 65001

SETLOCAL ENABLEDELAYEDEXPANSION
rem static start
rem Required programs
set vspipe=C:\Users\PUCK\AppData\Local\Programs\VapourSynth\core\vspipe.exe
set x265="C:\Program Files\Transcode\x265\x265.exe"
set ffmpeg="C:\Program Files\Transcode\ffmpeg\ffmpeg.exe"
rem static end


rem vs script start
echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=12000 >> "%~dpn1.vpy"
echo source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(source,threads=1) >> "%~dpn1.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo clip_8 = mvf.ToYUV(src,css="420",matrix="709",depth=8) >> "%~dpn1.vpy"
echo clip_10 = mvf.ToYUV(src,css="420",matrix="709",depth=10) >> "%~dpn1.vpy"
echo super_params="{pel:1,gpu:1,full:false,scale:{up:2,down:4}}" >> "%~dpn1.vpy"
echo analyse_params="{gpu:1,vectors:3,block:{w:8,h:8,overlap:2}}" >> "%~dpn1.vpy"
echo smoothfps_params="{rate:{num:5,den:2},algo:21,cubic:1}" >> "%~dpn1.vpy"
echo super=core.svp1.Super(clip_8,super_params) >> "%~dpn1.vpy"
echo vectors=core.svp1.Analyse(super["clip"],super["data"],clip_10,analyse_params) >> "%~dpn1.vpy"
echo smooth=core.svp2.SmoothFps(clip_10,super["clip"],super["data"],vectors["clip"],vectors["data"],smoothfps_params) >> "%~dpn1.vpy"
echo smooth=core.std.AssumeFPS(smooth,fpsnum=smooth.fps_num,fpsden=smooth.fps_den) >> "%~dpn1.vpy"
echo smooth.set_output() >> "%~dpn1.vpy" 
rem vs script end


ECHO Preparing media info......


rem get frames count and framerate
FOR /F "tokens=* USEBACKQ delims=" %%F IN (`!vspipe! --info "%~dpn1.vpy" -`) DO (
SET info=%%F
call :getinfo !info!
)
goto Encode


:getinfo
for /f "tokens=1 delims= " %%i in ("!info!") do (
if "%%i"=="Frames:" (
for /f "tokens=2 delims= " %%j in ("!info!") do (
set frames=%%j
)
)
if "%%i"=="FPS:" (
for /f "tokens=2 delims= " %%k in ("!info!") do (
set framerate=%%k
)
)
)
EXIT /B
goto:eof




:Encode
rem start encoding
%vspipe% --y4m "%~dpn1.vpy" - | %x265% ^
--y4m --preset slower --pools 8 --frame-threads 8 ^
--frames %frames% -D 10 --crf 21 --no-sao --aq-mode 1 --psy-rdoq 3.0 ^
--rdoq-level 2 --cbqpoffs -2 --crqpoffs -2 --me 3 --subme 3 ^
--qcomp 0.65 --aq-strength 0.8 --keyint 1 --ctu 32 --merange 44 ^
--range full --colorprim bt709 --transfer bt709 --colormatrix bt709 ^
--output "%~1.tmp" -
rem encoding done


ping 127.0.0.1 -n 2 >nul


rem remuxing encoded video with audio
%ffmpeg% -r %framerate% -i "%~1.tmp" -i "%~1" -map 0:v -map 1:a -vcodec copy -acodec copy "%~n1_svp.mp4"

ping 127.0.0.1 -n 1 >nul
Echo  
mshta vbscript:createobject("sapi.spvoice").speak("SVP encoding done!")(window.close)


rem delete tmp files
ECHO SVP encoding done! Press [Space] to delete TEMP files...
pause
del "%~dpn1.vpy"
del "%~dpn1%~x1.lwi"
del "%~1.tmp"
Echo Cleanup done!


pause