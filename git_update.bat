@echo off
setlocal enabledelayedexpansion

rem 获取 ESC 字符
for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"

rem 定义颜色
set "GREEN=%ESC%[0;32m"
set "RED=%ESC%[0;31m"
set "RESET=%ESC%[0m"

rem 选择菜单
:choose
cls
echo %GREEN%MENU%RESET%
echo %GREEN%1%RESET%. update (default)
echo %GREEN%2%RESET%. add new repository
echo %GREEN%3%RESET%. delete repository
echo %GREEN%q%RESET%. quit
echo.
echo input %GREEN%1%RESET%/%GREEN%2%RESET%/%GREEN%3%RESET%/%GREEN%q%RESET%/%GREEN%Enter%RESET%(default)

set /p choice=Enter your choice: 

if /i "%choice%"=="q" (
    goto end
) else if /i "%choice%"=="2" (
    rem 添加新的仓库
    echo.
    echo Enter the %GREEN%path%RESET% of the new repository:
    set /p newrepo=

    rem 处理新仓库路径
    if exist "!newrepo!" (
        if not exist repos.txt (
            >repos.txt echo !newrepo!
        ) else (
            >>repos.txt echo !newrepo!
        )
        echo !newrepo! %GREEN%add successfully%RESET%
        ping -n 2 127.0.0.1 >nul
        cls
        goto choose
    ) else (
        echo %RED%The specified path does not exist.%RESET%
        ping -n 2 127.0.0.1 >nul
        cls
        goto choose
    )
) else if /i "%choice%"=="3" (
    rem 删除现有的仓库
    echo.
    echo Enter the %RED%path%RESET% of the repository to delete:
    set /p delrepo=

    rem 处理删除仓库路径
    if exist repos.txt (
        set "tempfile=temp.txt"
        for /f "usebackq tokens=*" %%i in ("repos.txt") do (
            if /i not "%%i"=="!delrepo!" echo %%i>>"!tempfile!"
        )
        move /y "!tempfile!" repos.txt >nul
        echo !delrepo! %GREEN%delete successfully%RESET%
        ping -n 2 127.0.0.1 >nul
        cls
        goto choose
    ) else (
        echo %RED%The specified path does not exist in repos.txt%RESET%
        ping -n 2 127.0.0.1 >nul
        cls
        goto choose
    )
) else if /i "%choice%"=="1" (
    goto update
) else if "%choice%"=="" (
    goto update
) else (
    echo %RED%Invalid choice%RESET%
    ping -n 2 127.0.0.1 >nul
    cls
    goto choose
)

:update
rem 执行默认的更新操作
echo.
rem 遍历repos.txt中的每个目录并执行 git 命令
for /f "tokens=*" %%d in (repos.txt) do (
    if exist %%d (
        cd /d %%d
    ) else (
        echo %RED%Skipping%RESET% %%d %RED%[path does not exist]%RESET%
        echo.
        continue
    )
    if exist .git (
        echo %GREEN%Checking%RESET% %%d
        git diff-index --quiet HEAD --
        if not errorlevel 1 (
            echo %RED%No changes%RESET%
        ) else (
            echo %GREEN%Changes detected%RESET%
            git add .
            git commit -m "auto_update"
            git push
            echo %GREEN%Update successfully%RESET%
        )
    ) else (
        echo %RED%Skipping%RESET% %%d %RED%[not a git repository]%RESET%
    )
    echo.
)

:end
pause
endlocal