@echo off
:start
cd "/d %~dp0"
"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" --y4m "%~f1" - | "x264 location" - --demuxer y4m --input-depth 8 --crf 16.0 --deblock -1:-1 --qcomp 0.70 --trellis 2 --me umh --subme 10 --merange 24 --ref 8 --bframes 8 --b-adapt 2 --direct auto --aq-mode 3 --aq-strength 0.8 --min-keyint 1 --keyint 720 --rc-lookahead 72 --psy-rd 0.60:0.00 --no-fast-pskip --threads 12 --no-dct-decimate --no-mbtree --log-file "C:\%~n1.log" --output "C:\%~n1.mkv"
shift
if not "%~1"=="" goto start
echo. & pause