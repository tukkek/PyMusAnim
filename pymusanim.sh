#!/bin/bash
# given the same parameters as PyMusAnimLauncher, runs the whole process of creating a video
function checktime() {
  now=`date +%s`
}

if [ $# == 0 ]; then
  echo "Usage: ./pymusanim.sh file.mid outputdirectory/ [--dynamic]"
  exit 1
fi
name=`basename $1 .${1#*.}`
if [[ "$1" =~ \ |\' ]]; then
  echo "Found an illegal character in this path, please rename: $1"
  exit 2
fi

checktime;allStart=$now
python MusAnimLauncher.py $*
if [ $? -ne 0 ]; then
  exit 3
fi
checktime;echo "Total time: $((($now-$allStart)/60)) minutes ($((($now-$allStart))) seconds)"
cp $1 $2
timidity $1 -Ov -o $2/${name}.ogg
cd $2
ffmpeg -f image2 -i frame%5d.png -i ${name}.ogg -qscale 0 ${name}.mpg
rm *.png
checktime;echo "Total time: $((($now-$allStart)/60)) minutes ($((($now-$allStart))) seconds)"
