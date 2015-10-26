#!/bin/bash
#Converts a whole directory of MIDI files in parallel
OUT_DIR=output/

shopt -s nocaseglob
trap 'kill 0' EXIT
if [ ! $1 ]; then
  echo "Usage: batch.sh midisDirectory [threadsLimit]"
  exit 1
fi
mkdir $OUT_DIR
files=`ls -1 $1/*.mid*&>/dev/null`
if [ ! $? == 0 ]; then
  echo "No files found, aborting."
  exit
fi
for m in $1/*.mid*; do
  name=`basename $m .${m#*.}`
  nice -n19 ./pymusanim.sh $m $OUT_DIR$name &> $OUT_DIR${name}.log&
  echo "Starting $name"
  threadsLimit=$2
  if [ ! $threadsLimit ]; then
    threadsLimit=`cat /proc/cpuinfo | grep processor | wc -l`
  fi
  while [ `jobs|grep Running|wc -l` == $threadsLimit ]; do
    sleep 1
  done
done
wait
echo "Done"
first=1
./checklogs.sh $OUT_DIR