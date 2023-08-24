# function
mount_partitions_in_recovery() {
if [ "$BOOTMODE" != true ]; then
  DIR=/dev/block/bootdevice/by-name
  DIR2=/dev/block/mapper
  mount -o rw -t auto $DIR/vendor$SLOT /vendor\
  || mount -o rw -t auto $DIR2/vendor$SLOT /vendor\
  || mount -o rw -t auto $DIR/cust /vendor\
  || mount -o rw -t auto $DIR2/cust /vendor
  mount -o rw -t auto $DIR/product$SLOT /product\
  || mount -o rw -t auto $DIR2/product$SLOT /product
  mount -o rw -t auto $DIR/system_ext$SLOT /system_ext\
  || mount -o rw -t auto $DIR2/system_ext$SLOT /system_ext
  mount -o rw -t auto $DIR/odm$SLOT /odm\
  || mount -o rw -t auto $DIR2/odm$SLOT /odm
  mount -o rw -t auto $DIR/my_product /my_product\
  || mount -o rw -t auto $DIR2/my_product /my_product
  mount -o rw -t auto $DIR/userdata /data\
  || mount -o rw -t auto $DIR2/userdata /data
  mount -o rw -t auto $DIR/cache /cache\
  || mount -o rw -t auto $DIR2/cache /cache
  mount -o rw -t auto $DIR/persist /persist\
  || mount -o rw -t auto $DIR2/persist /persist
  mount -o rw -t auto $DIR/metadata /metadata\
  || mount -o rw -t auto $DIR2/metadata /metadata
  mount -o rw -t auto $DIR/cust /cust\
  || mount -o rw -t auto $DIR2/cust /cust
fi
}
remove_sepolicy_rule() {
rm -rf /metadata/magisk/"$MODID"\
 /mnt/vendor/persist/magisk/"$MODID"\
 /persist/magisk/"$MODID"\
 /data/unencrypted/magisk/"$MODID"\
 /cache/magisk/"$MODID"\
 /cust/magisk/"$MODID"
}
perf_service() {
SVC=`find /*/bin/hw /*/*/bin/hw -type f -name vendor.qti.hardware.perf@*`
}
enable_perf() {
resetprop vendor.post_boot.parsed 1
killall $SVC
}
disable_perf() {
resetprop vendor.post_boot.parsed 0
killall $SVC
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





