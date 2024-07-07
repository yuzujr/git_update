# git_update
a batch file that update your git repositories

#### usage
1. 保证`repos.txt`中末尾有一个空行，否则会和之前的仓库目录冲突
2. 更新行为默认为
   ```
   git add .
   git commit -m "auto_update"
   git push
   ```
   如有需要可以自行更改
