# space
ui_print " "

# var
UID=`id -u`

# log
if [ "$BOOTMODE" != true ]; then
  FILE=/data/media/"$UID"/$MODID\_recovery.log
  ui_print "- Log will be saved at $FILE"
  exec 2>$FILE
  ui_print " "
fi

# optionals
OPTIONALS=/data/media/"$UID"/optionals.prop
if [ ! -f $OPTIONALS ]; then
  touch $OPTIONALS
fi

# debug
if [ "`grep_prop debug.log $OPTIONALS`" == 1 ]; then
  ui_print "- The install log will contain detailed information"
  set -x
  ui_print " "
fi

# run
. $MODPATH/function.sh

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
  sed -i 's|#k||g' $MODPATH/post-fs-data.sh
else
  ui_print " MagiskVersion=$MAGISK_VER"
  ui_print " MagiskVersionCode=$MAGISK_VER_CODE"
fi
ui_print " "

# recovery
mount_partitions_in_recovery

# sepolicy
FILE=$MODPATH/sepolicy.rule
DES=$MODPATH/sepolicy.pfsd
if [ "`grep_prop sepolicy.sh $OPTIONALS`" == 1 ]\
&& [ -f $FILE ]; then
  mv -f $FILE $DES
fi

# cleaning
ui_print "- Cleaning..."
remove_sepolicy_rule
ui_print " "

# check
perf_service
if [ ! "$SVC" ]\
&& [ "`grep_prop force.install $OPTIONALS`" != 1 ]; then
  abort "! This vendor does not have Perf Touch Boost service"
fi

# apply
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
  sed -i 's|disable_perf|enable_perf|g' $MODPATH/service.sh
  sed -i 's|min_cpu_freq||g' $MODPATH/service.sh
  sed -i 's|Disables|Enables|g' $MODPATH/module.prop
  if [ "$BOOTMODE" == true ]; then
    ui_print "- Enables Perf Touch Boost now..."
    enable_perf
    ui_print "  Perf Touch Boost is already enabled"
    ui_print "  so you don't need to reboot"
    ui_print "  but keep this module installed"
    ui_print "  to enable Perf Touch Boost at every boot"
  else
    ui_print "- Enables Perf Touch Boost at boot"
  fi
fi
ui_print " "










