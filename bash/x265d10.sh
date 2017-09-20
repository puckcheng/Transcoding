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
echo SM.set_output() >> $name.vpy


echo Building File Index......


vspipe --y4m "$name.vpy"  - | x265 --y4m --preset slow --frame-threads 8 --crf 20 --deblock 0:0 -D 10 --merange 44 --aq-strength 0.8 --qcomp 0.65 --output "$name.hevc" -

echo done!

pause 'Press [Enter] to delete temp files...'

rm $name.vpy
rm $name.$ext.lwi
