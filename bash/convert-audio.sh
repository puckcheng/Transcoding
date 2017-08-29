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

ffmpeg -i "$file" -vn -f wav -acodec pcm_f32le -ar 44100 -ac 2 - | fdkaac -m 0 -f 0 -b 192 -a 1 -o "$name.m4a" -

pause
