#!/bin/bash

# get command line params
filename=$1
path=${2:-}


json -f $filename $path | pygmentize -l json


