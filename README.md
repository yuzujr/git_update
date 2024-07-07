# git_update
a batch file that update your git repositories

#### usage
1. Ensure there is a blank line at the end of `repos.txt`, otherwise it will conflict with the previous repository directory.
2. The default update behavior is:
   ```
   git add .
   git commit -m "auto_update"
   git push
   ```
   You can change it if necessary.
