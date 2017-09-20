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
pause(){
   read -p "$*"
}

getInput(){
      read -p "输入起始时间：" a1
      read -p "输入结束时间：" a2
}

caltime(){
declare -a min1
let hr1=$a1/3600
let min1=($a1%3600)/60
let sec1=$a1%60
let hr2=$a2/3600
let min2=($a2%3600)/60
let sec2=$a2%60
printf -v min1 "%02d" $min1
printf -v sec1 "%02d" $sec1
printf -v min2 "%02d" $min2
printf -v sec2 "%02d" $sec2

}

getDir
getFile
getName
getExt
getFolder


#dirname $dir 获取文件夹路径
#basename $dir 获取文件名称
cd $folder

getInput

if (( $a1 < $a2 )) && (( $a1 >= 0 ))
then caltime
else
    echo "Wrong number of timeline,please try again..."
fi


ffmpeg -i "$file" -vcodec copy -acodec copy -ss $hr1:$min1:$sec1 -to $hr2:$min2:$sec2 "$name.cuted.$ext"


pause
