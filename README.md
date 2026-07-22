# Touch Boost Disabler/Enabler Magisk Module

## Descriptions
- Perf Touch Boost is turning minimum CPU frequency into the maximum frequency (or in another way) while you are touching your screen to increase performance
- This module disables the Perf Touch Boost by default if you feel it's causing battery drain issue
- This module can also enable/re-enable the Perf Touch Boost (Please READ Optionals bellow!)

## Changelog

v0.7
- Update libmagiskpolicy.so from Magisk (stable) 30.7 (30700)
- Resets module folders/files permissions at post-fs-data
- Move _uninstall.log to /data/adb/logs/

v0.6
- Fix bug in uninstall.sh

v0.5
- Fix conflict with modules_update while installing via recovery if Magisk installed
- Sets cpu_min_freq to 0 if Perf Touch Boost is disabled

v0.4
- Redirect /sdcard to /data/media/"$UID"
- Add optional debug.log=1 for more detailed install log

v0.3
- Save install log at /sdcard/..._recovery.log if installing via Recovery
- Save uninstall log at /data/media/0/..._uninstall.log
- Fix mount required partitions while installing via Recovery
- Fix functions

v0.2
- Fix script bugs

v0.1
- Initial release

## Requirements
- vendor.qti.hardware.perf@*-service
- Magisk or Kitsune Mask or KernelSU or Apatch installed

## Installation Guide & Download Link
- Install this module https://github.com/reiryuki/Touch-Boost-Disabler-Enabler-Magisk-Module via Magisk app or Kitsune Mask app or KernelSU app or Apatch app or Recovery if Magisk or Kitsune Mask installed
- You don't need to reboot except you are installing via Recovery

## Optionals
- https://t.me/ryukinotes/76
- Global: https://t.me/ryukinotes/35

## Troubleshootings
Global: https://t.me/ryukinotes/34

## Known Issue
Cannot play video if Perf Touch Boost is disabled in some ROMs

## Support & Bug Report
- https://t.me/ryukinotes/54
- If you don't do above, issues will be closed immediately

## Credits and Contributors
- https://t.me/androidryukimodsdiscussions
- https://t.me/androidappsportdevelopment

## Sponsors
https://t.me/ryukinotes/25


