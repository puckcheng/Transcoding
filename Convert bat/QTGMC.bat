@ECHO OFF

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
echo core = vs.get_core(accept_lowercase=True,threads=12) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo #src=core.ffms2.Source(Source) >> "%~dpn1.vpy"
echo src=core.std.Trim(src,38548,103351) >> "%~dpn1.vpy"
echo clip=haf.QTGMC(src,Preset="fast",TFF=True) >> "%~dpn1.vpy"
echo clip=clip[::2] >> "%~dpn1.vpy"
echo #clip=core.vivtc.VFM(clip,order=1,field=2,mode=1) >> "%~dpn1.vpy"
echo clip=core.vivtc.VDecimate(clip) >> "%~dpn1.vpy"
echo BM3D=mvf.BM3D(clip,sigma=[8,0,0],radius1=0,profile1="lc") >> "%~dpn1.vpy"
echo BM3D.set_output() >> "%~dpn1.vpy"

Echo Building File Index......

%vspipe% --y4m "%~dpn1.vpy" - | %x265% ^
--y4m --preset slow --frame-threads 6 ^
-D 10 --crf 20 ^
--qcomp 0.65 --merange 44 --aq-strength 0.8 ^
--deblock=1:0 --output "D:\Media\TEMP\%~n1_%num%.mkv" -


Echo  
::ping 127.0.0.1 -n 1 >nul
::mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

Echo Press [Space] to delete TEMP files
pause
del "%~dpn1.vpy"
del "%~dpn1%~x1.lwi"
del "%~dpn1%~x1.ffindex"
Echo done!
pause