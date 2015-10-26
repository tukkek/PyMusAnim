#!/bin/bash
# given the same parameters as PyMusAnimLauncher, runs the whole process of creating a video
function doNow() {
  now=`date +%s`
}

doNow;allStart=$now
python MusAnimLauncher.py $*
if [ ! $? == 0 ]; then
  echo "usage: ./pymusanim.sh [file.mid] [output directory name]"
  exit 1
fi
timidity $1 -Ov -o $2/a.ogg
cd $2
ffmpeg -f image2 -i frame%5d.png -i a.ogg -sameq a.mpg #sameq is same_quant in upstream
doNow;echo "Total time: $((($now-$allStart)/60)) minutes"
