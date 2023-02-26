@echo off
:fileanalyzestart
title Directory Reader
setlocal enabledelayedexpansion

set /a total_files=0
set /a music_files=0
set /a video_files=0
set /a exe_files=0
set /a image_files=0

:input
set /p directory=Enter the directory to scan [%CD%]:
if "%directory%"=="" set "directory=%CD%"

if not exist "%directory%" (
    echo Invalid directory.
    set /p retry=Do you want to try again? [y/n]:
    if /i "%retry%"=="y" goto input
    exit /b
)

for /r "%directory%" %%f in (*) do (
    set /a total_files+=1
    if "%%~xf"==".mp3" set /a music_files+=1
    if "%%~xf"==".avi" set /a video_files+=1
    if "%%~xf"==".exe" set /a exe_files+=1
    if "%%~xf"==".jpg" set /a image_files+=1
    if "%%~xf"==".jpeg" set /a image_files+=1
    if "%%~xf"==".png" set /a image_files+=1
)

echo Total files: %total_files%

    set /a music_percent=0
    set /a video_percent=0
    set /a exe_percent=0
    set /a image_percent=0

    if %music_files% gtr 0 set /a music_percent=music_files*100/total_files
    if %video_files% gtr 0 set /a video_percent=video_files*100/total_files
    if %exe_files% gtr 0 set /a exe_percent=exe_files*100/total_files
    if %image_files% gtr 0 set /a image_percent=image_files*100/total_files
    set "music_bar="
    set "video_bar="
    set "exe_bar="
    set "image_bar="

    for /l %%i in (1,1,100) do (
        if %%i leq %music_percent% set "music_bar=!music_bar!#"
        if %%i leq %video_percent% set "video_bar=!video_bar!#"
        if %%i leq %exe_percent% set "exe_bar=!exe_bar!#"
        if %%i leq %image_percent% set "image_bar=!image_bar!#"
    )
	echo File Analyzation:
    echo Music files: %music_files% (%music_percent%%) !music_bar!
    echo Video files: %video_files% (%video_percent%%) !video_bar!
    echo Executable files: %exe_files% (%exe_percent%%) !exe_bar!
    echo Image files: %image_files% (%image_percent%%) !image_bar!
	echo.
powershell.exe -ExecutionPolicy Bypass -File "%CD%\driveReader.ps1" "C"

pause
cls