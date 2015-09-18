#!/bin/bash

# Restore win current path
cwd=$(echo "$(pwd)/$1" | sed -e 's@/cygdrive/c/@C:\\@g' -e 's@/@\\@g')
echo $cwd
"/cygdrive/c/Program Files/TortoiseGit/bin/TortoiseGitProc.exe" -closeonend 0 -command blame -path $cwd &

printf "\n"
