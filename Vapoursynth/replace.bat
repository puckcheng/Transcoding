SetLocal EnableDelayedExpansion

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source="%~dpn1%x1" >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo BM3D=mvf.BM3D(src,sigma=[3,3,3],radius1=0) >> "%~dpn1.vpy"
echo BM3D.set_output() >> "%~dpn1.vpy"

ping 127.0.0.1 -n 1

For %%i In (%~dpn1.vpy) Do (
    For /F "Usebackq Delims=" %%j In ("%%~nxi") Do (
        Set Str=%%j
        Echo !Str:\=\\!>>New_%%~nxi
    )
    Del %%~nxi >nul
    Ren New_%%~nxi %%~nxi
)