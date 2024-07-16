setlocal enabledelayedexpansion
for %%d in (
    D:\your\repository\path
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
