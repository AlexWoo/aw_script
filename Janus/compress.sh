#!/bin/bash
# 功能说明：
# 

path=$1
roomid=$2
format=$3

cd $path

if [[ $path == "" ]];then
    exit 2
fi

if [[ $roomid == "" ]];then
    exit 2
fi

if [[ $format != "vp8" ]];then
    format="h264"
fi 

filerex=$roomid"_*"
fileinfo=`ls -1 $filerex`
fileflag="uploadfilename:"

for i in $fileinfo; do
    filename=$i
    # echo "000000, $i"
    # echo `basename $i`
    # echo `dirname $i`
    basename=${i%*"video.mjr"}
    if [[ $i == $basename ]];then
        basename=${i%*"audio.mjr"}
        # /usr/bin/janus-pp-rec --header $i
        /usr/bin/janus-pp-rec $i "${basename}audio.opus"
        if [[ $? -eq 0 ]]; then
            echo "${fileflag}${basename}audio.opus"
        fi
    else
        if [[ $format == "vp8" ]];then
            # /usr/bin/janus-pp-rec --header $i
            /usr/bin/janus-pp-rec $i "${basename}video.webm"
            if [[ $? -eq 0 ]]; then
                echo "${fileflag}${basename}video.webm"
            fi
        elif [[ $format == "h264" ]];then
            # /usr/bin/janus-pp-rec --header $i
            /usr/bin/janus-pp-rec $i "${basename}video.mp4"
            if [[ $? -eq 0 ]]; then
                echo "${fileflag}${basename}video.mp4"
            fi
        fi
    fi
done
