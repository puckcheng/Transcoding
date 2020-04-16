@ECHO OFF & CD /D "%~dp1"

set num=%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
rem static start
rem Required programs
set vspipe="C:\Program Files (x86)\VapourSynth\core64\vspipe.exe"
set mediainfo="C:\Program Files (x86)\MediainfoCLI\MediaInfo.exe"
set x265="C:\Program Files (x86)\MeGUI\tools\x265\x64\x265.exe"
rem static end


echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo import nnedi3_resample as nnrs >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.d2v.Source(Source,threads=1) >> "%~dpn1.vpy"
echo clip = core.vivtc.VFM(src, order=1, field=2, mode=1) >> "%~dpn1.vpy"
echo clip = core.vivtc.VDecimate(clip, cycle=5) >> "%~dpn1.vpy"
echo clip = core.std.Trim(clip,0,8560) >> "%~dpn1.vpy"
echo clip = core.std.SetFrameProp(clip,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo clip = core.std.CropAbs(clip,720,404,top=40)  >> "%~dpn1.vpy"
echo clip = core.resize.Spline36(clip, width=2160, height=1212) >> "%~dpn1.vpy"
echo #super_params="{pel:1,gpu:1,scale:{up:2,down:4}}" >> "%~dpn1.vpy"
echo #analyse_params="{gpu:1,block:{w:8,h:8,overlap:3}}" >> "%~dpn1.vpy"
echo #smoothfps_params="{rate:{num:5,den:2}}" >> "%~dpn1.vpy"
echo #super=core.svp1.Super(clip,super_params) >> "%~dpn1.vpy"
echo #vectors=core.svp1.Analyse(super["clip"],super["data"],clip,analyse_params) >> "%~dpn1.vpy"
echo #smooth=core.svp2.SmoothFps(clip,super["clip"],super["data"],vectors["clip"],vectors["data"],smoothfps_params) >> "%~dpn1.vpy"
echo #smooth=core.std.AssumeFPS(smooth,fpsnum=smooth.fps_num,fpsden=smooth.fps_den) >> "%~dpn1.vpy"
echo #smooth=nnrs.nnedi3_resample(smooth)  >> "%~dpn1.vpy"
echo clip.set_output()  >> "%~dpn1.vpy"

Echo Building File Index......

%vspipe% --y4m "%~dpn1.vpy" - | %x265% ^
--y4m --preset slower --pools 20 --frame-threads 8 ^
--frames 8561 -D 8 --crf 18 --no-sao --aq-mode 1 --psy-rdoq 3.0 ^
--rdoq-level 2 --cbqpoffs -2 --crqpoffs -2 --me 3 --subme 3 ^
--qcomp 0.65 --aq-strength 0.8 --ctu 32 --merange 44 ^
--output "%~n1.hevc" -



Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)
Echo done!
pause