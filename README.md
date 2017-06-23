#Some scripts for work under cygwin

##cjson.sh*
**Experemental**
Print colorized JSON
```bash
#Print JSON
cjson file.json
#Get JSON by path
cjson file.json path.to
```
##git_branch_desc.sh*
Show branch list with description (git branch --edit-description)
Add to alias block in.gitconfig: branch-list = !sh /path/to/git_branch_desc.sh
```bash
git branch-list
```

##git-remote-eql.sh
**WARNING: Adapted for private workflow!**
Check equal to repository (local-remote) on HEAD hash, branch name, diff
Add to alias block in.gitconfig: script-remote-eql = !sh /path/to/git-remote-eql.sh
```bash
git script-remote-eql prjname remotehost
```

##grall.sh
Search pattern in files
```bash
grall _\.[a-zA-z]
grall _\.[a-zA-z] ./some/folder
```

##grjs.sh
Same as grjs, only search in *.js files

##grxml.sh
Same as grjs, only search in *.xml files

##sl.sh
Warapper around Sublime Text
```bash
#Open file
sl ./filename.txt
#Open folder and create project
sl ./folder/name
#Piping
grjs varname | sl
```

##tgitblame.sh
##tgitdiff.sh



# COOKBOOK
## render with curl
curl "http://localhost:1332/api-be/business-entity-type/code/quittance" -s -H "token: f1f7bc7bfb7870f36e6fcf356cfe5a62eb3ae2a4f236ae582484d1dbaf1f9e9c" | jq -r '.schema' | jsf