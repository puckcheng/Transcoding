@ECHO OFF & CD/D "%~dp0"
IF "%~1"==""GOTO :STOP
IF /I "%~x1"==".mkv" (Set Ext=.hevc) ELSE (GOTO :STOP)

"C:\Program Files (x86)\MeGUI_2715_x86\tools\x265\avs4x26x.exe" --x26x-binary "C:\Program Files (x86)\MeGUI_2715_x86\tools\x265\x64\x265.exe" --preset slow --crf 18.0 -D 10 --sar 1:1 --output "%~dp0\%~dpn1%Ext%" "%~dp0\%~dp1.avs"


:STOP
pause

