#!/bin/bash

if test -t 0
then
	/cygdrive/c/Program\ Files/Sublime\ Text\ 3/subl.exe $*
else
	# echo "Not yet! Read data from stdin"
	timestamp=`date +%s`
	filename=$1
	shift
	if [ -z $filename ]; then filename=".temp$timestamp" ; fi
	touch "$filename"
	while read data
	do
		echo "$data" >> "$filename"
	done
	/cygdrive/c/Program\ Files/Sublime\ Text\ 3/subl.exe $filename $*
	sleep 1
	rm "$filename"
fi