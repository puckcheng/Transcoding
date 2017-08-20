import vapoursynth as vs
import sys


core = vs.get_core(accept_lowercase=True,threads=8)
core.max_cache_size=10000


clip = core.ffms2.Source(source=r'C:\Users\PUCK\Desktop\IMAX.mkv')
clip = clip.resize.Bicubic(format=vs.YUV420P8)

super_params="{pel:1,gpu:0}"
analyse_params="{gpu:1,block:{w:8,h:8}}"
smoothfps_params="{rate:{num:5,den:2}}" #帧率的比例num/den=分子/分母

super=core.svp1.Super(clip,super_params)
vectors=core.svp1.Analyse(super["clip"],super["data"],clip,analyse_params)
smooth=core.svp2.SmoothFps(clip,super["clip"],super["data"],vectors["clip"],vectors["data"],smoothfps_params)
smooth=core.std.AssumeFPS(smooth,fpsnum=smooth.fps_num,fpsden=smooth.fps_den)

smooth.set_output()
