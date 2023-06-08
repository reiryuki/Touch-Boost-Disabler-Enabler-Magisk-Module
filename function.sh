# function
enable_perf() {
resetprop vendor.post_boot.parsed 1
killall vendor.qti.hardware.perf@*-service
}
disable_perf() {
resetprop vendor.post_boot.parsed 0
killall vendor.qti.hardware.perf@*-service
}
min_cpu_freq() {
FILE=`find /sys -name affected_cpus`
ACS=`[ "$FILE" ] && cat $FILE`
FILE=`find /sys -name cpuinfo_min_freq`
CIMFS=`[ "$FILE" ] && cat $FILE`
FILES=`find /sys -name scaling_min_freq -o -name cpu_min_freq`
SMF=`[ "$FILES" ] && cat $FILES`
for AC in $ACS; do
  for CIMF in $CIMFS; do
    for FILE in $FILES; do
      chmod 0664 $FILE
      echo $AC:$CIMF > $FILE
    done
  done
done
SMF=`[ "$FILES" ] && cat $FILES`
}


