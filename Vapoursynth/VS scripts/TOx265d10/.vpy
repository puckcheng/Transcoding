import vapoursynth as vs 
import sys 
import havsfunc as haf 
import mvsfunc as mvf 
core = vs.get_core(accept_lowercase=True,threads=8) 
core.max_cache_size=8000 
Source=r'' 
src=core.lsmas.LWLibavSource(Source,threads=1) 
src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) 
BM3D=mvf.BM3D(src,sigma=[3,3,3],radius1=0,profile1="fast") 
BM3D.set_output() 
