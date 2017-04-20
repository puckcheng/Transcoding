@ECHO OFF

cd "/d %~dp0"

set str_time_first_bit="%time:~0,1%"  
if %str_time_first_bit%==" " (  
    set str_date_time=%date:~0,4%%date:~5,2%%date:~8,2%_0%time:~1,1%%time:~3,2%%time:~6,2%)else (   
    set str_date_time=%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%)  
set output=%str_date_time%

"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" --y4m "%~f1"  - | "C:\Program Files (x86)\MeGUI_2715_x86\tools\x265\x64\x265.exe" --y4m --preset slow --frame-threads 8 --crf 20 --deblock 0:0 -D 10 --merange 44 --aq-strength 0.8 --qcomp 0.65 --output "D:\Media\TEMP\%output%.hevc" -

pause

