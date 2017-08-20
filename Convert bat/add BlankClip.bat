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
echo blank=core.std.BlankClip(clip=src, width=1920, height=1080, length=240, color=[0,128,128]) >> "%~dpn1.vpy"
echo long=src+blank >> "%~dpn1.vpy"
echo long.set_output() >> "%~dpn1.vpy"

Echo Building File Index......

"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" "%~dpn1.vpy" --y4m - | "C:\Program Files (x86)\MeGUI_2715_x86\tools\ffmpeg\ffmpeg.exe" -i pipe: encoded.mkv

Echo  
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

Echo Press Space to delete TEMP files
pause
del "%~dpn1.vpy"
del "%~dpn1%~x1.lwi"
Echo done!

pause



