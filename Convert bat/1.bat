@ECHO OFF  & CD/D "%~dp1"

set /p n="请输入分离音轨数量:"
echo %n%
set /a n=%n%-1
echo %n%

for /l %%i in (0,1,%n%) do (

echo %%i

)

pause