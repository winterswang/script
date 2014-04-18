#!/bin/bash

cat packagename_list.txt |while read line
do
    length=$((${#line} -2))
    echo $line| cut -b 1-$length
done
