(

mount /data
mount -o rw,remount /data
MODPATH=${0%/*}

# debug
exec 2>$MODPATH/debug.log
set -x

# wait
sleep 60

# property
resetprop sys.post_boot.parsed 0
resetprop vendor.post_boot.parsed 0

# restart
killall /vendor/bin/hw/vendor.qti.hardware.perf@*-service

) 2>/dev/null


