#!/bin/bash


project=${1:-makeup}
ROOT=${2:-/home/dergaev/yawork/}
hostname=${3:-mino}


host="$hostname.yandex.ru"
path="$ROOT$project"

printf "...\n"
printf  "Check \e[32m\"$project\"\e[0m (\e[31m$host\e[0m:$path)\n"


#Branch name should be equal
git_branchname="git rev-parse --abbrev-ref HEAD"
local_branch=$($git_branchname)
remote_branch=$(ssh $host "cd $path; $git_branchname")
if [ "$local_branch" == "$remote_branch" ]; then
	branch_res="\e[32mOK\e[0m"
else
	branch_res="\e[31mErr\e[0m"
fi
printf " -> Branch name-$branch_res ( $local_branch <-> $remote_branch )\n"

#HEAD commit should be equal
git_last_commit="git rev-parse --short HEAD"
local_last_commit=$($git_last_commit)
remote_last_commit=$(ssh $host "cd $path; $git_last_commit")
if [ "$local_last_commit" == "$remote_last_commit" ]; then
	hash_commit_res="\e[32mOK\e[0m"
else
	hash_commit_res="\e[31mErr\e[0m"
fi
printf " -> HEAD commit-$hash_commit_res ( $local_last_commit <-> $remote_last_commit )\n"

#DIFF should be equal
git_diff="git diff"
local_diff=$($git_diff)
remote_diff=$(ssh $host "cd $path; $git_diff")

# f_local_diff="LOCAL:$local_diff"
# f_remote_diff="REMOTE:$remote_diff"

# echo $f_local_diff
# echo $f_remote_diff

if [ "$local_diff" == "$remote_diff" ]; then
	diff_res="\e[32mOK\e[0m"
else
	diff_res="\e[31mErr\e[0m"
fi
printf " -> diff-$diff_res\n"


