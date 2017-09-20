import vapoursynth as vs 
import sys 
import havsfunc as haf 
import mvsfunc as mvf 
core = vs.get_core(accept_lowercase=True,threads=8) 
core.max_cache_size=8000 
Source=r'/Users/puck/Downloads/IMAX.mkv' 
src=core.lsmas.LWLibavSource(Source,threads=8) 
<<<<<<< HEAD
src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) 
#src = src.resize.Spline36(clip=src, format=vs.YUV420P8, matrix_in_s="709")
#BM3D=mvf.BM3D(src,sigma=[10,3,3],radius1=0) 
src.set_output() 


=======
src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0)
#res=core.resize.Spline36(clip=src, width=1280, height=720)

#super_params="{pel:1,gpu:0}"
#analyse_params="{gpu:0,vectors:3,block:{w:8,h:8}}"
#smoothfps_params="{rate:{num:5,den:2}}"
#super=core.svp1.Super(res,super_params)
#vectors=core.svp1.Analyse(super["clip"],super["data"],res,analyse_params)
#smooth=core.svp2.SmoothFps(res,super["clip"],super["data"],vectors["clip"],vectors["data"],smoothfps_params)
#smooth=core.std.AssumeFPS(smooth,fpsnum=smooth.fps_num,fpsden=smooth.fps_den)
#blank=core.std.BlankClip(clip=smooth, width=1280, height=720, length=600, color=[0,128,128])
#long=smooth+blank
#long.set_output()
clip=core.deblock.Deblock(src,quant=25,aoffset=0,boffset=0)
clip.set_output()
>>>>>>> origin/master
