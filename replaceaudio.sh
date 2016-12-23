#!/bin/bash
function usage() {
  echo "Usage: ./replaceaudio.sh directory/"
  echo ""
  echo "This utility takes a directory name and will use the following files"
  echo "to create a new video with a given audio track:"
  echo "- audio.mid (will be converted to ogg with timidity)"
  echo "- video.mpg (will used as video input, current audio being ignored)"
}

if [ $# == 0 ]; then
  usage;exit 1
fi
cd $1
if [ ! -e "audio.mid" ] || [ ! -e "video.mpg" ]; then
  usage;exit 2
fi
timidity audio.mid -Ov -o audio.tmp.ogg
ffmpeg -i video.mpg -codec copy -an silent.tmp.mpg
ffmpeg -i silent.tmp.mpg -i audio.tmp.ogg -vcodec copy replaced.mpg
rm audio.tmp.ogg
rm silent.tmp.mpg
