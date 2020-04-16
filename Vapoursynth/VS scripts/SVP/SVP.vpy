import vapoursynth as vs
import sys
import mvsfunc as mvf

core = vs.get_core(threads=8)
core.max_cache_size=8000

src = core.lsmas.LWLibavSource(source=r'E:\FOOTAGE\无限宅腐2019.9\NINJAV_S001_S001_T017.MOV',threads=1)
src = core.std.SetFrameProp(src,prop="_FieldBased",intval=0)

clip_8 = mvf.ToYUV(src,css="420",depth=8)
clip_10 = mvf.ToYUV(src,css="420",depth=10)

super_params="{pel:1,gpu:1,full:false,scale:{up:2,down:4}}"
analyse_params="{gpu:1,vectors:3,block:{w:8,h:8,overlap:2}}"
smoothfps_params="{rate:{num:5,den:2},algo:21,cubic:1}" #帧率的比例num/den=分子/分母

super=core.svp1.Super(clip_8,super_params)
vectors=core.svp1.Analyse(super["clip"],super["data"],clip_10,analyse_params)
smooth=core.svp2.SmoothFps(clip_10,super["clip"],super["data"],vectors["clip"],vectors["data"],smoothfps_params)
smooth=core.std.AssumeFPS(smooth,fpsnum=smooth.fps_num,fpsden=smooth.fps_den)

smooth.set_output()
