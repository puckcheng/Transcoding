import vapoursynth as vs 
import sys 
import havsfunc as haf 
import mvsfunc as mvf 
core = vs.get_core(accept_lowercase=True,threads=8) 
core.max_cache_size=8000 
Source=r'Z:\FILM\1920s\Ben-Hur A Tale of the Christ.avi' 
src=core.lsmas.LWLibavSource(Source,threads=8) 
src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) 
BM3D=mvf.BM3D(src,sigma=[10,3,3],radius1=0) 
BM3D.set_output() 
