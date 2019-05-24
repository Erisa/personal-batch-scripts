@echo off
echo Pushing meta files to Internal Storage..
"C:\path\adb.exe" shell mkdir -v /sdcard/meta
"C:\path\adb.exe" push "C:\meta\pass.asc" /sdcard/meta/
"C:\path\adb.exe" push "C:\meta\id_rsa" /sdcard/meta/
"C:\path\adb.exe" push "C:\meta\id_ed25519" /sdcard/meta/
REM "C:\path\adb.exe" push "C:\meta\mobile_rsa" /sdcard/meta/

REM echo Process completed.
REM pause>nul
