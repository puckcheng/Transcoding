@ECHO OFF & CD/D "%~dp1"

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo res=core.resize.Spline36(clip=src, width=1280, height=720) >> "%~dpn1.vpy"
echo blank=core.std.BlankClip(clip=res, width=1280, height=720, length=240, color=[0,128,128]) >> "%~dpn1.vpy"
echo long=res+blank >> "%~dpn1.vpy"
echo long.set_output() >> "%~dpn1.vpy"

Echo Building File Index......

"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" "%~dpn1.vpy" --y4m - | "C:\Program Files (x86)\MeGUI_2715_x64\tools\x264\x264.exe" --demuxer y4m --pass 1 --crf 18 --force-cfr --fps 23.976 --stats "%~dpn1.stats" --slow-firstpass --threads 8 --bframes 5 --b-adapt 2 --ref 4 --chroma-qp-offset -4 --rc-lookahead 48 --merange 32 --me tesa --direct auto --subme 11 --trellis 2 --psy-rd 0.00:0.15 --output "%~dpn1_pass1.h264" -

Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

Echo done!
pause



