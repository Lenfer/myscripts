#!/bin/bash

for filename in "$@"
do
	/cygdrive/c/Program\ Files/Sublime\ Text\ 3/subl.exe $filename
done