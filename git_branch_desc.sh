#!/bin/bash

branches=$(git for-each-ref --format='%(refname)' refs/heads/ | sed 's|refs/heads/||')
for branch in $branches; do
	desc=$(git config branch.$branch.description)
	if [ $branch == $(git rev-parse --abbrev-ref HEAD) ]; then
		branch="* \033[0;32m$branch\033[0m"
	else
		branch="  $branch"
fi
echo -e "$branch \033[0;36m$desc\033[0m"
done
