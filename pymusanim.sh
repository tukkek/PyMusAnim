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
        mscore "$1" -o $converted #convert mid->mid 2> /dev/null
        python MusAnimLauncher.py $converted $2 $3 #second try
        if [ $? -ne 0 ]; then exit 1; fi #second try failed
    fi
}

if [ $# == 0 ]; then echo "Usage: ./pymusanim.sh file.mid outputdirectory/ [--dynamic]"; exit 2; fi
if [ -e $2 ]; then echo 'Output folder already exists...'; exit 3; fi
type mscore 2&>/dev/null;musescore=$?
type timidity 2&>/dev/null;timidity=$?
checktime;allStart=$now
animate $*
printtime
cp $1 $2
./render.sh $2
printtime
