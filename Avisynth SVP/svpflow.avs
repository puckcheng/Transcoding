Cores=16
SetMemoryMax(8000)
SetMTMode(3,Cores)
PluginPath = "C:\Program Files (x86)\MeGUI_2715_x86\tools\avisynth_plugin\"
LoadPlugin(PluginPath+"svpflow1.dll")
LoadPlugin(PluginPath+"svpflow2.dll")
Import(PluginPath+"InterFrame2.avsi")
LoadPlugin("C:\Program Files (x86)\MeGUI_2715_x86\tools\lsmash\LSMASHSource.dll")
LWLibavVideoSource("D:\EXPORT\L4D2 OP-Final.mp4").ConvertToYV12()
SetMTMode(2)
#deinterlace
#crop
#denoise
#resize
InterFrame(Cores=Cores)