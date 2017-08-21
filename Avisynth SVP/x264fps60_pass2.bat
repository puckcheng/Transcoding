@ECHO OFF & CD/D "%~dp1"

echo Cores=16 > "%~dpn1.avs"
echo SetMemoryMax(8000) >> "%~dpn1.avs"
echo SetMTMode(3,Cores) >> "%~dpn1.avs"
echo PluginPath = "C:\Program Files (x86)\MeGUI_2715_x86\tools\avisynth_plugin\" >> "%~dpn1.avs"
echo LoadPlugin(PluginPath+"svpflow1.dll") >> "%~dpn1.avs"
echo LoadPlugin(PluginPath+"svpflow2.dll") >> "%~dpn1.avs"
echo Import(PluginPath+"InterFrame2.avsi") >> "%~dpn1.avs"
echo LoadPlugin("C:\Program Files (x86)\MeGUI_2715_x86\tools\lsmash\LSMASHSource.dll") >> "%~dpn1.avs"
echo Src=LWLibavVideoSource("%~dpn1%~x1").ConvertToYV12().Spline36Resize(1280,720) >> "%~dpn1.avs"
echo Src ++ Blackness(Src, Length=240) >> "%~dpn1.avs"
echo SetMTMode(2) >> "%~dpn1.avs"
echo InterFrame(Cores=Cores) >> "%~dpn1.avs"

"C:\Program Files (x86)\MeGUI_2715_x86\tools\x264\avs4x26x.exe" --x26x-binary "C:\Program Files (x86)\MeGUI_2715_x86\tools\x264\x264.exe" --pass 2 --bitrate 1800 --force-cfr --fps 59.94 --stats "%~dpn1.stats" --threads 8 --bframes 5 --b-adapt 0 --ref 4 --chroma-qp-offset -4 --rc-lookahead 48 --merange 32 --me tesa --direct auto --subme 11 --trellis 2 --psy-rd 0.00:0.15 --output "%~dpn1_pass2.h264" "%~dpn1.avs"


pause

