@echo off
echo [1/10] Clearing data...
"C:\path\fastboot.exe" set_active a
"C:\path\fastboot.exe" -w

echo [2/10] Clearing system...
"C:\path\fastboot.exe" erase system

echo [3/11] Flashing TWRP to boot...
"C:\path\fastboot.exe" flash boot_a "C:\meta\twrp-3.3.0-0-pioneer.img"

REM echo [4/10] Flashing TWRP to B...
REM "C:\path\fastboot.exe" flash boot_b "C:\meta\twrp-3.3.0-0-pioneer.img"

echo [4/11] Rebooting...
"C:\path\fastboot.exe" reboot
echo Waiting for device to reappear. Do not touch anything when TWRP loads.
"C:\path\adb.exe" wait-for-recovery

REM echo [6/10] Pushing install files..
REM "C:\path\adb.exe" shell mkdir -v /sdcard/meta
REM "C:\path\adb.exe" push "C:\meta\lineage-16.0-20190601-nightly-pioneer-signed.zip" /sdcard/meta/
REM "C:\path\adb.exe" push "C:\meta\Magisk-v19.1.zip" /sdcard/meta/
REM "C:\path\adb.exe" push "C:\meta\open_gapps-arm64-9.0-nano-20190426.zip" /sdcard/meta/

echo [5/11] Installing LineageOS...
"C:\path\adb.exe" shell twrp remountrw system
"C:\path\adb.exe" shell twrp sideload
"C:\path\adb.exe" wait-for-sideload
"C:\path\adb.exe" sideload "C:\meta\lineage-16.0-20190601-nightly-pioneer-signed.zip"

echo [6/11] Rebooting TWRP due to system remount bug...
"C:\path\adb.exe" wait-for-recovery
"C:\path\adb.exe" reboot bootloader
"C:\path\fastboot.exe" boot "C:\meta\twrp-3.3.0-0-pioneer.img"
"C:\path\fastboot.exe" reboot
echo Waiting for device to reappear. Do not touch anything when TWRP loads.
"C:\path\adb.exe" wait-for-recovery

echo [7/11] Installing Magisk...
"C:\path\adb.exe" shell twrp sideload
"C:\path\adb.exe" wait-for-sideload
"C:\path\adb.exe" sideload "C:\meta\Magisk-v19.1.zip"
REM "C:\path\adb.exe" shell twrp install "/sdcard/meta/Magisk-v19.1.zip"

echo [8/11] Pushing meta files...
"C:\path\adb.exe" wait-for-recovery
call "C:\scripts\push_meta_int.bat"

echo [9/11] Installing OpenGAPPS...
"C:\path\adb.exe" shell twrp remountrw system
"C:\path\adb.exe" shell twrp sideload
"C:\path\adb.exe" wait-for-sideload
"C:\path\adb.exe" sideload "C:\meta\open_gapps-arm64-9.0-nano-20190426.zip"
REM "C:\path\adb.exe" shell twrp install /sdcard/meta/open_gapps-arm64-9.0-nano-20190426.zip

echo [10/11] Enabling ADB...
"C:\path\adb.exe" wait-for-recovery
"C:\path\adb.exe" shell echo -n 'mtp,adb' > /data/property/persist.sys.usb.config
"C:\Windows\System32\OpenSSH\ssh-keygen.exe" -y -f %USERPROFILE%\.android\adbkey > %USERPROFILE\.android\adbkey.pub
"C:\path\adb.exe" push %USERPROFILE%\.android\adbkey.pub /data/misc/adb/adb_keys

echo [11/11] Rebooting to system...
"C:\path\adb.exe" wait-for-recovery
"C:\path\adb.exe" reboot

echo Waiting for device to appear as system to verify success.
echo 
"C:\path\adb.exe" wait-for-device

echo Should be done!
pause