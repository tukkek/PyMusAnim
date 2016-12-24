#!/bin/bash
# given the same parameters as PyMusAnimLauncher, runs the whole process of creating a video
function checktime() { now=`date +%s`;}
function printtime(){
    checktime
    timeelapsed=$(($now-$allStart))
    echo "Total time: $(($timeelapsed/60)) minutes ($timeelapsed seconds)"
}
function animate(){
    python MusAnimLauncher.py $* #first try
    if [ $? -ne 0 ]; then
        if ! [ $musescore ]; then exit 1; fi #first try failed
        echo "Converting MIDI..."
        converted="$2/musescore.mid"
        #echo mscore "$1" -o $converted #convert mid->mid
        mscore "$1" -o $converted #convert mid->mid 2> /dev/null
        python MusAnimLauncher.py $converted $2 $3 #second try
        if [ $? -ne 0 ]; then exit 1; fi #second try failed
    fi
}
function record(){
    for midi in *.mid*; do #call pymusanim if there is an idle thread
        if [ $timidity ]; then
            me=`whoami`
            while [ ps -u $me|grep timidity ]; do sleep 1; done #wait for other instances to finish
            timidity $midi -Ov -o "$midi.timidity.ogg"
        fi
        if [ $musescore ] ; then
            while [ ps -u $me|grep mscore ]; do sleep 1; done #wait for other instances to finish
            mscore $midi -o "$midi.musescore.ogg"
        fi
    done
}
function convert(){
    ffmpeg -f image2 -i frame%5d.png -qscale 0 silent.tmp.mpg
    for ogg in *.ogg; do #call pymusanim if there is an idle thread
        ffmpeg -i silent.tmp.mpg -i $ogg -vcodec copy "$ogg.mpg"
    done
    rm *.png
    rm silent.tmp.mpg
}

if [ $# == 0 ]; then echo "Usage: ./pymusanim.sh file.mid outputdirectory/ [--dynamic]"; exit 2; fi
if [ -e $2 ]; then echo 'Output folder already exists...'; exit 3; fi
#name=`basename $1 .${1#*.}`; if [[ "$1" =~ \ |\' ]]; then echo "Found an illegal character in this path, please rename: $1"; exit 4; fi
type mscore 2&>/dev/null;musescore=$?
type timidity 2&>/dev/null;timidity=$?

checktime;allStart=$now
animate $*
printtime
cp $1 $2
cd $2
record $*
convert $*
printtime
