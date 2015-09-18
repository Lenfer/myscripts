#!/bin/bash

# get command line params
pattern=$1
path=${2:-./}
ctxLen=${3:-5}

grep -E $pattern --color=always -rni $path -C $ctxLen --include=*.xml | less -r -p $pattern


