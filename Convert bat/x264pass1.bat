@ECHO OFF & CD/D "%~dp1"

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo clip=core.fmtc.resample(src,w=1920,h=1080,css="420",kernel="spline36") >> "%~dpn1.vpy"
echo #clip=core.fmtc.bitdepth(clip,bits=8) >> "%~dpn1.vpy"
echo clip=haf.ChangeFPS(clip,24000,1000) >> "%~dpn1.vpy"
echo clip.set_output() >> "%~dpn1.vpy"

Echo Building File Index......

"C:\Users\Puckcheng\AppData\Local\Programs\VapourSynth\core\vspipe.exe" "%~dpn1.vpy" --y4m - | "C:\Program Files (x86)\MeGUI\tools\x264\x264.exe" --demuxer y4m --preset veryslow --pass 1 --bitrate 2800 --vbv-bufsize 23000 --vbv-maxrate 20000 --stats "pass.stats" --slow-firstpass --deblock 1:0:0 --bframes 12 --b-adapt 2 --b-pyramid normal --ref 4 --qcomp 0.75 --qpmax 36 --chroma-qp-offset -4 --threads 18 --rc-lookahead 72 --merange 32 --keyint 250 --min-keyint 1 --me tesa --direct auto --range tv --colorprim bt709 --transfer bt709 --colormatrix bt709 --no-fast-pskip --subme 11 --trellis 2 --psy-rd 1.00:0.15 --input-depth 10 --level 4.1 --output "%~dp1pass1.h264" -


Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

Echo done!

pause

