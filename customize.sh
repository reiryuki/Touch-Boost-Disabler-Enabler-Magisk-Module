# space
ui_print " "

# info
MODVER=`grep_prop version $MODPATH/module.prop`
MODVERCODE=`grep_prop versionCode $MODPATH/module.prop`
ui_print " ID=$MODID"
ui_print " Version=$MODVER"
ui_print " VersionCode=$MODVERCODE"
if [ "$KSU" == true ]; then
  ui_print " KSUVersion=$KSU_VER"
  ui_print " KSUVersionCode=$KSU_VER_CODE"
  ui_print " KSUKernelVersionCode=$KSU_KERNEL_VER_CODE"
else
  ui_print " MagiskVersion=$MAGISK_VER"
  ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
fi
ui_print " "

# optionals
OPTIONALS=/sdcard/optionals.prop
if [ ! -f $OPTIONALS ]; then
  touch $OPTIONALS
fi

# mount
if [ "$BOOTMODE" != true ]; then
  if [ -e /dev/block/bootdevice/by-name/vendor ]; then
    mount -o rw -t auto /dev/block/bootdevice/by-name/vendor /vendor
  else
    mount -o rw -t auto /dev/block/bootdevice/by-name/cust /vendor
  fi
  mount -o rw -t auto /dev/block/bootdevice/by-name/persist /persist
  mount -o rw -t auto /dev/block/bootdevice/by-name/metadata /metadata
fi

# sepolicy
FILE=$MODPATH/sepolicy.rule
DES=$MODPATH/sepolicy.pfsd
if [ "`grep_prop sepolicy.sh $OPTIONALS`" == 1 ]\
&& [ -f $FILE ]; then
  mv -f $FILE $DES
fi

# cleaning
ui_print "- Cleaning..."
rm -rf /metadata/magisk/$MODID
rm -rf /mnt/vendor/persist/magisk/$MODID
rm -rf /persist/magisk/$MODID
rm -rf /data/unencrypted/magisk/$MODID
rm -rf /cache/magisk/$MODID
ui_print " "

# check
FILE=`find /vendor/bin/hw /system/vendor/bin/hw\
     -type f -name vendor.qti.hardware.perf@*-service*`
if [ ! "$FILE" ]\
&& [ "`grep_prop module.test $OPTIONALS`" != 1 ]; then
  abort "! This vendor does not have Perf Touch Boost service"
fi

# run
. $MODPATH/function.sh
if [ "`grep_prop touch.boost $OPTIONALS`" != 1 ]; then
  if [ "$BOOTMODE" == true ]; then
    ui_print "- Disables Perf Touch Boost now..."
    disable_perf
    min_cpu_freq
    ui_print "  Perf Touch Boost is already disabled"
    ui_print "  so you don't need to reboot"
    ui_print "  but keep this module installed"
    ui_print "  to disable Perf Touch Boost at every boot"
  else
    ui_print "- Disables Perf Touch Boost at boot"
  fi
else
  if [ "$BOOTMODE" == true ]; then
    ui_print "- Enables Perf Touch Boost now..."
    enable_perf
    sed -i 's|disable_perf|enable_perf|g' $MODPATH/service.sh
    sed -i 's|min_cpu_freq||g' $MODPATH/service.sh
    sed -i 's|Disables|Enables|g' $MODPATH/module.prop
    ui_print "  Perf Touch Boost is already enabled"
    ui_print "  so you don't need to reboot"
    ui_print "  but keep this module installed"
    ui_print "  to enable Perf Touch Boost at every boot"
  else
    ui_print "- Enables Perf Touch Boost at boot"
  fi
fi
ui_print " "










