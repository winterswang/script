#!/bin/bash
filename=$1

if [ ! $filename ] ;then
echo "need input a name"
exit
fi

TOPDIR=$(cd $(dirname "$0") && pwd)
source $TOPDIR/localrc

if [ ! $filename == "have1" ] ;then
url=$HAVE1
fi

if [ ! $filename == "have2" ] ;then
url=$HAVE2
fi

cat $filename |while read line
do
    echo $url$line
    wget -c  $url$line
done
