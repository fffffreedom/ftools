# git command
- checkout a branch from the commit id
```
#　git log
...
commit a77173168daf7c2d411b642f71988b06008bd181
Author: awssdkgo <awssdkgo@awssdkgo-2b-3f09e729.us-west-2.amazon.com>
Date:   Wed Jun 7 22:30:32 2017 +0000
...
```
the commit is the SHA1, now you can check：
```
git checkout -b <new_branch_name> <SHA1>
```
