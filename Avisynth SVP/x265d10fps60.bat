@ECHO OFF 

echo Cores=16 > "%~dpn1.avs"
echo SetMemoryMax(8000) >> "%~dpn1.avs"
echo SetMTMode(3,Cores) >> "%~dpn1.avs"
echo PluginPath = "C:\Program Files (x86)\MeGUI_2715_x86\tools\avisynth_plugin\" >> "%~dpn1.avs"
echo LoadPlugin(PluginPath+"svpflow1.dll") >> "%~dpn1.avs"
echo LoadPlugin(PluginPath+"svpflow2.dll") >> "%~dpn1.avs"
echo Import(PluginPath+"InterFrame2.avsi") >> "%~dpn1.avs"
echo LoadPlugin("C:\Program Files (x86)\MeGUI_2715_x86\tools\lsmash\LSMASHSource.dll") >> "%~dpn1.avs"
echo LWLibavVideoSource("%~dpn1%~x1").ConvertToYV12() >> "%~dpn1.avs"
echo SetMTMode(2) >> "%~dpn1.avs"
echo InterFrame(Cores=Cores) >> "%~dpn1.avs"


"C:\Program Files (x86)\MeGUI_2715_x86\tools\x265\avs4x26x.exe" --x26x-binary "C:\Program Files (x86)\MeGUI_2715_x86\tools\x265\x64\x265.exe" --preset slow --crf 18.0 -D 10 --sar 1:1 --output "%~dpn1.hevc" "%~dpn1.avs"


pause

