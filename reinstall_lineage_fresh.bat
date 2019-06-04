@echo off
echo [1/10] Clearing data...
"C:\path\fastboot.exe" -w

echo [2/10] Clearing system...
"C:\path\fastboot.exe" erase system

echo [3/9] Flashing TWRP to boot...
"C:\path\fastboot.exe" flash boot_a "C:\meta\twrp-3.3.0-0-pioneer.img

"C:\path\fastboot.exe" set_active a

echo [4/9] Rebooting...
"C:\path\fastboot.exe" reboot
echo Waiting for device to reappear. Do not touch anything when TWRP loads.
"C:\path\adb.exe" wait-for-recovery

echo [5/9] Installing LineageOS...
"C:\path\adb.exe" shell twrp remountrw system
"C:\path\adb.exe" shell twrp sideload
"C:\path\adb.exe" wait-for-sideload
"C:\path\adb.exe" sideload "C:\meta\lineage-16.0-20190603-nightly-pioneer-signed.zip"

echo [6/9] Rebooting TWRP due to system remount bug...
"C:\path\adb.exe" wait-for-recovery
"C:\path\adb.exe" reboot bootloader
"C:\path\fastboot.exe" boot "C:\meta\twrp-3.3.0-0-pioneer.img"
echo Waiting for device to reappear. Do not touch anything when TWRP loads.
"C:\path\adb.exe" wait-for-recovery

echo [7/9] Installing Magisk...
"C:\path\adb.exe" shell twrp sideload
"C:\path\adb.exe" wait-for-sideload

"C:\path\adb.exe" sideload "C:\meta\Magisk-v19.2.zip"

echo [8/9] Installing OpenGAPPS...
"C:\path\adb.exe" shell twrp remountrw system
"C:\path\adb.exe" shell twrp sideload
"C:\path\adb.exe" wait-for-sideload
"C:\path\adb.exe" sideload "C:\meta\open_gapps-arm64-9.0-nano-20190426.zip"

echo [9/9] Rebooting to system...
"C:\path\adb.exe" wait-for-recovery
"C:\path\adb.exe" reboot

echo Waiting for device to appear as system to verify success.
echo 
"C:\path\adb.exe" wait-for-device

echo Should be done!
pause