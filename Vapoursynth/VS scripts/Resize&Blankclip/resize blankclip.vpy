import vapoursynth as vs 
import sys 
import havsfunc as haf 
import mvsfunc as mvf 
core = vs.get_core(accept_lowercase=True,threads=8) 
core.max_cache_size=8000 
Source=r'C:\Users\PUCK\Desktop\IMAX.mkv' 
src=core.lsmas.LWLibavSource(Source,threads=1) 
src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) 
res=core.resize.Spline36(clip=src,width=1280,height=720, format=vs.YUV420P8, matrix_s="709")
blank=core.std.BlankClip(clip=res, format=vs.YUV420P8, length=240, width=1280, height=720, color=[0,0,0])
long=res+blank
long.set_output() 
