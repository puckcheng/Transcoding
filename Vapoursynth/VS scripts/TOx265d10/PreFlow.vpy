import vapoursynth as vs 
import sys 
import havsfunc as haf 
import mvsfunc as mvf 
core = vs.get_core(accept_lowercase=True,threads=8) 
core.max_cache_size=8000 
Source=r'/Users/puck/Downloads/IMAX.mkv' 
src=core.lsmas.LWLibavSource(Source,threads=8) 
src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) 
#src = src.resize.Spline36(clip=src, format=vs.YUV420P8, matrix_in_s="709")
#BM3D=mvf.BM3D(src,sigma=[10,3,3],radius1=0) 
src.set_output() 


