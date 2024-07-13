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
        set "GIT_STATUS_OUTPUT="
        for /f "delims=" %%i in ('git status --short') do set GIT_STATUS_OUTPUT=%%i
        if not "!GIT_STATUS_OUTPUT!"=="" (
            git add .
            git commit -m "auto_update"
            git push
        )
    )
    pause
)
endlocal
