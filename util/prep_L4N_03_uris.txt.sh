#!/bin/bash

set -x

modir=$PWD

if [ $# -lt 1 ]; then
  echo "Please specify working directory!"
  echo "Usage: $0 working_directory"
  exit 1
fi

wd=$1

cat ${wd}/L4N-*-split-*.md5 > md5list.txt
cp md5list.txt $modir/l4n_win

cd $modir/l4n_win

mv uris.txt uris.txt.old

sed -e 's@MD5(@https://www.nemotos.net/l4n-abis/L4N-2004-ABIS-20221107-split/@' -e 's@)@\r  check-integrity=true\n@' -e 's@= @  checksum=md5=@' -e 's@https@\rhttps@' md5list.txt | nkf -sLw > uris.txt

