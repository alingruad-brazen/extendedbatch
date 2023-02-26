
@echo off
setlocal enabledelayedexpansion
:CMDstart

set /a count=0
for %%f in (*.bat *.exe *.ps1) do (
    set /a count+=1
    set "file[!count!]=%%f"
    echo !count!. %%f
)

set /p choice=Enter the number of the file you want to run:
if "%choice%"=="CD" (
cd /d %~dp0
goto CMDstart
)
if %choice% gtr 0 if %choice% leq %count% (
    set /p "add_argument=Do you want to add an argument for the selected file? (Y/N) - "
    if /i "!add_argument!"=="Y" (
        set /p "argument=Enter the argument:  "
        if /i "!file[%choice%]:~-3!"==".ps1" (
            powershell.exe -ExecutionPolicy Bypass -File "!file[%choice%]!" !argument!
        ) else (
            call "!file[%choice%]!" !argument!
        )
    ) else (
        if /i "!file[%choice%]:~-3!"==".ps1" (
            powershell.exe -ExecutionPolicy Bypass -File "!file[%choice%]!"
        ) else (
            call "!file[%choice%]!"
        )
    )
) else (
    echo Invalid selection.
)

echo.
goto CMDstart