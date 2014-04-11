SOURCE_DIR=build/peak-linux-driver-7.9
KERNEL_VER=/usr/src/linux-headers-"`uname -r`"

# apply patch for current Linux kernel versions
#patch -p0 < patch.diff

cd $SOURCE_DIR && make install KERNEL_LOCATION=$KERNEL_VER DBG=NO_DEBUG MOD=MODVERSIONS PAR=PARPORT_SUBSYSTEM USB=USB_SUPPORT PCI=PCI_SUPPORT DNG=DONGLE_SUPPORT ISA=NO PCC=NO NET=NO RT=NO

cd driver && make NET=NO

make install

insmod pcan.ko
modprobe pcan
./pcan_make_devices 2
