#!/bin/bash

if [ $# -ne 3 ]
then
  echo 'usage: record_radiko_and_upload_to_dropbox.sh CHANNEL MINUTES TITLE'
  exit 1
fi

cd `dirname $0`
filename=$3_`date '+%Y_%m%d_%H%M'`.mp3
./record_radiko.sh $1 $2 $filename && ./dropbox_uploader.sh upload $filename && rm $filename

