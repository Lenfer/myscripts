#!/bin/bash

if test -t 0
then
	/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $*
else
	timestamp=`date +%s`
	filename=$1
	shift
	if [ -z $filename ]; then filename=".temp$timestamp" ; fi
	touch "$filename"
	while read data
	do
		echo "$data" >> "$filename"
	done
	/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $filename $*
	sleep 1
	rm "$filename"
fi
