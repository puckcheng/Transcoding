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


echo "import vapoursynth as vs" > $name.vpy
echo "import sys" >> $name.vpy
echo "import havsfunc as haf" >> $name.vpy
echo "import mvsfunc as mvf" >> $name.vpy
echo "core = vs.get_core(accept_lowercase=True,threads=8)" >> $name.vpy
echo "core.max_cache_size=8000" >> $name.vpy
echo "Source=r'$dir'" >> $name.vpy
echo "src=core.lsmas.LWLibavSource(Source,threads=1)" >> $name.vpy
echo clip=core.std.SetFrameProp"("src,prop="\"_FieldBased"\",intval=0")" >> $name.vpy
echo SM=haf.SMDegrain"(clip,tr=2,thSAD=300,contrasharp=True,chroma=False,plane=0)" >> $name.vpy
echo res=core.resize.Spline36"("clip=clip, width=1280, height=720")" >> $name.vpy
echo res.set_output() >> $name.vpy

echo Building File Index......

vspipe "$name.vpy" --y4m - | x264 --demuxer y4m --pass 2 --bitrate 1800 --force-cfr --fps 59.94 --stats "$name.stats" --slow-firstpass --threads 8 --bframes 5 --b-adapt 0 --ref 4 --chroma-qp-offset -4 --rc-lookahead 48 --merange 32 --me tesa --direct auto --subme 11 --trellis 2 --psy-rd 0.00:0.15 --output "$name.h264" -

echo done!

pause 'Press [Enter] to delete temp files...'

rm $name.vpy
rm $name.$ext.lwi
