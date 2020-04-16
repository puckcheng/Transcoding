import vapoursynth as vs
import sys
import havsfunc as haf
import mvsfunc as mvf
core = vs.get_core(threads=8)
core.max_cache_size=4000
Source=r''
src=core.lsmas.LWLibavSource(Source,threads=1)
src=core.std.Trim(src,59000,73000)
clip=core.fmtc.resample(src,w=1920,h=1080,css="420",kernel="spline36")
src.set_output()