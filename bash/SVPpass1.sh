#! /bin/bash

getDir(){
    read -p "Drag media file to encode...
    " dir
}

getFile(){
    file="${dir##*/}"
}

getExt(){
    ext="${file##*.}"
}

getName(){
    name="${file%%.*}"
}

getFolder(){
    folder="${dir%/*}"
}
function pause(){
   read -p "$*"
}


getDir
getFile
getName
getExt
getFolder


#dirname $dir 获取文件夹路径
#basename $dir 获取文件名称
cd $folder

echo import vapoursynth as vs > "%~dpn1.vpy"
echo import sys >> "%~dpn1.vpy"
echo import havsfunc as haf >> "%~dpn1.vpy"
echo import mvsfunc as mvf >> "%~dpn1.vpy"
echo core = vs.get_core(accept_lowercase=True,threads=8) >> "%~dpn1.vpy"
echo core.max_cache_size=8000 >> "%~dpn1.vpy"
echo Source=r'%~dpn1%~x1' >> "%~dpn1.vpy"
echo src=core.lsmas.LWLibavSource(Source,threads=1) >> "%~dpn1.vpy"
echo src=core.std.SetFrameProp(src,prop="_FieldBased",intval=0) >> "%~dpn1.vpy"
echo res=core.resize.Spline36(clip=src, width=1280, height=720) >> "%~dpn1.vpy"

echo super_params="{pel:1,gpu:0}" >> "%~dpn1.vpy"
echo analyse_params="{gpu:0,vectors:3,block:{w:8,h:8}}" >> "%~dpn1.vpy"
echo smoothfps_params="{rate:{num:5,den:2}}" >> "%~dpn1.vpy"

echo super=core.svp1.Super(res,super_params) >> "%~dpn1.vpy"
echo vectors=core.svp1.Analyse(super["clip"],super["data"],res,analyse_params) >> "%~dpn1.vpy"
echo smooth=core.svp2.SmoothFps(res,super["clip"],super["data"],vectors["clip"],vectors["data"],smoothfps_params) >> "%~dpn1.vpy"
echo smooth=core.std.AssumeFPS(smooth,fpsnum=smooth.fps_num,fpsden=smooth.fps_den) >> "%~dpn1.vpy"
echo blank=core.std.BlankClip(clip=smooth, width=1280, height=720, length=600, color=[0,128,128]) >> "%~dpn1.vpy"
echo long=smooth+blank >> "%~dpn1.vpy"
echo long.set_output() >> "%~dpn1.vpy"


Echo Building File Index......

"C:\Program Files (x86)\VapourSynth\core64\vspipe.exe" "%~dpn1.vpy" --y4m - | "C:\Program Files (x86)\MeGUI_2715_x64\tools\x264\x264.exe" --demuxer y4m --pass 1 --crf 18 --force-cfr --fps 59.94 --stats "%~dpn1.stats" --slow-firstpass --threads 8 --bframes 5 --b-adapt 2 --ref 4 --chroma-qp-offset -4 --rc-lookahead 48 --merange 32 --me tesa --direct auto --subme 11 --trellis 2 --psy-rd 0.00:0.15 --output "%~dpn1_pass1.h264" -

Echo 
ping 127.0.0.1 -n 1 >nul
mshta vbscript:createobject("sapi.spvoice").speak("Job done!")(window.close)

Echo done!
pause
