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

ffmpeg -i "$name.flv" -vcodec copy -acodec copy "$name.mp4"

pause
