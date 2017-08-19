import vapoursynth as vs
import sys
import havsfunc as haf
import mvsfunc as mvf


core = vs.get_core(accept_lowercase=True,threads=8)
#接受小写以及设定线程数

core.max_cache_size=8000
#最大使用内存

Source="Z:\\FILM\\1920s\\Christensen.Benjamin.Häxan[1922]\\Christensen.Benjamin.Häxan[1922].avi"
#源文件地址

src=core.lsmas.LWLibavSource(Source,threads=1)
#载入源滤镜

src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0)
#设定扫描模式

#trim=core.std.Trim(res,0，100） 
#切割0到100帧（普通写法）

#video=clip[0:101] 
#切割0到100帧（语法糖）

#cropped=core.std.CropRel(clip=src,left=0,right=0)
#裁剪视频

#res=core.Resize.Spline36(clip=cropped,width=1920,height=1080)
#缩放视频

#longvideo=video1+video2+video3
#合并视频（语法糖）

#longvideo=core.std.Splice([video1,video2,video3],mismatch=1)
#合并视频（普通方法）mismatch时也强行合并

BM3D=mvf.BM3D(src,sigma=[3,3,3],radius1=0)
#降噪

#dbed=core.f3kdb.Deband(src,12,32,24,24,0,0)
#去色带

#ass=core.assvapour.AssRender(dbed,"xxx.ass")
#加字幕


BM3D.set_output() 