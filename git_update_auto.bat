setlocal enabledelayedexpansion
for %%d in (
    D:\c++\Clion
    D:\c++\Sublime
    D:\c++\VS\trunk
    D:\c++\vscode
    D:\c++\vscode\note
    D:\Python\Pycharm\learning
    D:\Python\Sublime
    D:\rust
    D:\git_update\
) do (
    cd /d %%d
    if exist .git (
        git diff-index --quiet HEAD --
        if errorlevel 1 (
            git add .
            git commit -m "auto_update"
            git push
        )
    )
)
endlocal
