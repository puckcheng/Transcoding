@ECHO OFF & CD/D "%~dp1"

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=14) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo #src=core.ffms2.Source(Source) >> "%~dpn1.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo #SM=haf.SMDegrain(src,tr=2,thSAD=300,contrasharp=True,chroma=False,plane=0) >> "%~dpn1.vpy"
echo #src=core.std.Trim(src,0,107892) >> "%~dpn1.vpy"
echo BM3D=mvf.BM3D(src,sigma=[8,0,0],radius1=0,profile1="lc") >> "%~dpn1.vpy"
echo BM3D.set_output() >> "%~dpn1.vpy"

Echo Building File Index......

"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" --y4m "%~dpn1.vpy"  - | "C:\Program Files (x86)\MeGUI_2715_x64\tools\x265\x64\x265.exe" --y4m --preset slow --frame-threads 14 --crf 20 --deblock 1:0 -D 10 --merange 44 --aq-strength 0.8 --qcomp 0.65 --output "D:\Media\TEMP\%~n1.mkv" -

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



