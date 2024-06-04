mount -o rw,remount /data
MODPATH=${0%/*}

# log
exec 2>$MODPATH/debug.log
set -x

# wait
until [ "`getprop sys.boot_completed`" == 1 ]; do
  sleep 10
done

# run
. $MODPATH/function.sh
perf_service
disable_perf
min_cpu_freq







