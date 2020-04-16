@ECHO OFF & CD /D "%~dp1"


rem static start
rem Required programs
set vspipe="C:\Program Files (x86)\VapourSynth\core64\vspipe.exe"
set mediainfo="C:\Program Files (x86)\MediainfoCLI\MediaInfo.exe"
set x265="C:\Program Files (x86)\MeGUI\tools\x265\x64\x265.exe"
rem static end

SETLOCAL ENABLEDELAYEDEXPANSION
SETLOCAL

%mediainfo% "--Inform=Video;%%FrameCount%%" "%~dpn1%~x1" > "D:\Media\TEMP\frames.txt"
FOR /F %%i in (D:\Media\TEMP\frames.txt) do set tframe=%%i
set /a tframe=%tframe%*2


echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo import nnedi3_resample as nnrs >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=16000 >> "%~dpn1.vpy"
echo core.std.LoadPlugin(path=r'C:\Program Files (x86)\VapourSynth\plugins64\Waifu2x-caffe\Waifu2x-caffe.dll') >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo clip = core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo clip = core.fmtc.bitdepth(clip,bits=32) >> "%~dpn1.vpy"
echo clip=core.caffe.Waifu2x(clip,noise=0,scale=2,block_w=320,block_h=180,model=4,cudnn=False,processor=0,tta=False) >> "%~dpn1.vpy"
echo clip=mvf.ToYUV(clip,matrix = "709", css = "420", depth = 8) >> "%~dpn1.vpy"
echo super_params="{pel:1,gpu:1,scale:{up:2,down:4}}" >> "%~dpn1.vpy" 
echo analyse_params="{gpu:1,block:{w:8,h:8,overlap:3}}" >> "%~dpn1.vpy" 
echo smoothfps_params="{rate:{num:2,den:1}}" >> "%~dpn1.vpy" 
echo super=core.svp1.Super(clip,super_params) >> "%~dpn1.vpy" 
echo vectors=core.svp1.Analyse(super["clip"],super["data"],clip,analyse_params) >> "%~dpn1.vpy" 
echo smooth=core.svp2.SmoothFps(clip,super["clip"],super["data"],vectors["clip"],vectors["data"],smoothfps_params) >> "%~dpn1.vpy" 
echo smooth=core.std.AssumeFPS(smooth,fpsnum=smooth.fps_num,fpsden=smooth.fps_den) >> "%~dpn1.vpy" 
echo smooth=core.std.Trim(smooth, 0, 10599) >> "%~dpn1.vpy"
echo smooth.set_output() >> "%~dpn1.vpy"  

Echo Building File Index......

%vspipe% --y4m "%~dpn1.vpy" - | %x265% ^
--y4m --preset slower --pools 16 --frame-threads 8 ^
--frames 10600 -D 8 --crf 18 --no-sao --aq-mode 1 --psy-rdoq 3.0 ^
--rdoq-level 2 --cbqpoffs -2 --crqpoffs -2 --me 3 --subme 3 ^
--qcomp 0.65 --aq-strength 0.8 --ctu 32 --merange 44 ^
--output "%~n1.hevc" -

ENDLOCAL

Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)
Echo done!
pause