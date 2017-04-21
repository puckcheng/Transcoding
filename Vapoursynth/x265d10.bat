@ECHO OFF & CD/D "%~dp1"

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source="%~dpn1%~x1" >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo BM3D=mvf.BM3D(src,sigma=[3,3,3],radius1=0) >> "%~dpn1.vpy"
echo BM3D.set_output() >> "%~dpn1.vpy"

ping 127.0.0.1 -n 2
SetLocal EnableDelayedExpansion

    For /F "Usebackq Delims=" %%j In ("%~dpn1.vpy") Do (
        Set Str=%%j
        Echo !Str:\=\\!>>PreFlow.vpy
    )
    Del "%~dpn1.vpy" >nul

SetLocal DisableDelayedExpansion
ping 127.0.0.1 -n 2

"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" --y4m "PreFlow.vpy"  - | "C:\Program Files (x86)\MeGUI_2715_x86\tools\x265\x64\x265.exe" --y4m --preset slow --frame-threads 8 --crf 20 --deblock 0:0 -D 10 --merange 44 --aq-strength 0.8 --qcomp 0.65 --output "D:\Media\TEMP\%~n1.hevc" -

pause
pause
pause

set str_time_first_bit="%time:~0,1%"  
if %str_time_first_bit%==" " (  
    set str_date_time=%date:~0,4%%date:~5,2%%date:~8,2%_0%time:~1,1%%time:~3,2%%time:~6,2%)else (   
    set str_date_time=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%)  
set output=%str_date_time%
