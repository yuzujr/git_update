# git_update
a batch file that update your git repositories

#### usage
1. Ensure there is a blank line at the end of `repos.txt`, otherwise it will conflict with the previous repository directory.
2. The default update behavior is:
   ```
   git add .
   git commit -m "the commit message you input"
   git push
   ```
   You can change it in bat if necessary,or just type **manual** when asked for commit message to complete the update yourself if ***the three*** cannot meet your needs.
4. The `git_update_auto` is faster and more concise,which is more suitable for automated execution.
