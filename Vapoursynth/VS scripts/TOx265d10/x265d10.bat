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
echo BM3D=mvf.BM3D(src,sigma=[3,3,3],radius1=0) >> "%~dpn1.vpy"
echo BM3D.set_output() >> "%~dpn1.vpy"

Echo 生成文件索引中，请耐心等待。。。

"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" --y4m "%~dpn1.vpy"  - | "C:\Program Files (x86)\MeGUI_2715_x86\tools\x265\x64\x265.exe" --y4m --preset slow --frame-threads 8 --crf 20 --deblock 0:0 -D 10 --merange 44 --aq-strength 0.8 --qcomp 0.65 --output "D:\Media\TEMP\%~n1.hevc" -

Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

pause
del "%~dpn1.vpy"
del "%~dpn1.lwi"
Echo 删除vpy以及lwi文件成功！
pause



