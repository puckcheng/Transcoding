@ECHO OFF & CD/D "%~dp1"

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(threads=1) >> "%~dpn1.vpy"
echo core.max_cache_size=4000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo #src=core.ffms2.Source(Source) >> "%~dpn1.vpy"
echo src=core.std.Trim(src,59000,73000) >> "%~dpn1.vpy"
echo #src=haf.ChangeFPS(src,25000,1000) >> "%~dpn1.vpy"
echo #BM3D=mvf.BM3D(src,sigma=[8,0,0],radius1=0,profile1="lc") >> "%~dpn1.vpy"
echo src.set_output() >> "%~dpn1.vpy"

Echo Building File Index......

"C:\Users\Puckcheng\AppData\Local\Programs\VapourSynth\core\vspipe.exe" --y4m "%~dpn1.vpy" - | "C:\Program Files\Transcode\x265\x265-10.exe" --y4m --preset slower --crf 21 --ref 4 --ctu 32 --weightb --bframes 6 --rc-lookahead 100 --no-open-gop --keyint 360 --min-keyint 1 --me 3 --subme 3 --merange 44 --no-rect --no-amp --no-sao --aq-mode 2 --aq-strength 0.9 --frame-threads 8 --rd 4 --psy-rd 2.0 --psy-rdoq 3.0 --rdoq-level 2 --pbratio 1.2 --cbqpoffs -2 --crqpoffs -2 --scenecut 40 --deblock 2:1 -D 10 --qcomp 0.65 --output "%~dpn1.hevc" -

Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

Echo Press [Space] to delete TEMP files
pause
del "%~dpn1.vpy"
del "%~dpn1%~x1.lwi"
del "%~dpn1%~x1.ffindex"
Echo done!
pause



