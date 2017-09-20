@ECHO OFF  & CD/D "%~dp1"

set /p n="请输入分离音轨数量:"

set /a n=%n%-1

for /l %%i in (0,1,%n%) do (

"C:\Program Files (x86)\MeGUI_2715_x64\tools\ffmpeg\ffmpeg.exe" -i "%~dpn1%~x1" -vn -map 0:a:%%i -c copy "D:\Media\TEMP\%~n1_a%%i.aac"

)

echo done!

pause