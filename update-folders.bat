@echo off
rem Lists every folder inside "images" in images\folders.js, so the viewer can show them in its menu,
rem and copies each folder's metadata.json (if it has one) into that file, so the information card
rem also works when the page is opened from disk.
rem Run it again whenever you add, rename or remove a box folder, or change a metadata.json.
chcp 65001 >nul
cd /d "%~dp0"
if not exist "images" mkdir "images"
set "OUT=images\folders.js"
> "%OUT%" echo window.BOX_FOLDERS = [
for /d %%F in ("images\*") do >> "%OUT%" echo   "%%~nxF",
>> "%OUT%" echo ];
>> "%OUT%" echo window.BOX_META_TEXT = {};
for /d %%F in ("images\*") do if exist "%%~F\metadata.json" call :meta "%%~nxF"
echo Updated %OUT%:
type "%OUT%"
pause
goto :eof

:meta
>> "%OUT%" echo BOX_META_TEXT["%~1"] = function () {/*
>> "%OUT%" type "images\%~1\metadata.json"
>> "%OUT%" echo.
>> "%OUT%" echo */};
goto :eof
