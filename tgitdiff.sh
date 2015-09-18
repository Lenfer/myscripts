#!/bin/bash

printf "\n"

# Restore win current path
cwd=$(pwd | sed -e 's@/cygdrive/c/@C:\\@g' -e 's@/@\\@g')
printf "  \e[0;32mPath: $cwd\e[0m\n"

matchHash="^[0-9a-zA-Z]+$"

# Prepare revision 1 value
if [[ ! $1 =~ $matchHash ]];
then
	t1="(tag: $1)"
fi
rev1=$(git rev-list $1 --max-count=1)
if [[ ! $rev1 =~ $matchHash ]];
then
	printf "\e[0;31m  ERROR: Revision '$1' don\`t found in repo. $rev1\e[0m\n\n"
	exit 1
fi

# Prepare revision 2 value
if [[ ! $2 =~ $matchHash ]];
then
	t2="(tag: $2)"
fi
rev2=$(git rev-list $2 --max-count=1)
if [[ ! $rev2 =~ $matchHash ]];
then
	printf "\e[0;31m  ERROR: Revision '$2' don\`t found in repo. $rev2\e[0m\n\n"
	exit 1
fi

printf "\e[0;32m  Revision #1: $rev1 $t1\n  Revision #2: $rev2 $t2\e[0m\n"


"/cygdrive/c/Program Files/TortoiseGit/bin/TortoiseGitProc.exe" -closeonend 0 -command showcompare -revision1 $rev1 -revision2 $rev2 -path $cwd &

printf "\n"
