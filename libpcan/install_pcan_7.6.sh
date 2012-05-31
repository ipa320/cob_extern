SOURCE_DIR=build/peak-linux-driver-7.6
KERNEL_VER=/usr/src/linux-headers-"`uname -r`"

cd $SOURCE_DIR/driver && make clean
make KERNEL_LOCATION=$KERNEL_VER DBG=NO_DEBUG MOD=MODVERSIONS PAR=PARPORT_SUBSYSTEM USB=USB_SUPPORT PCI=PCI_SUPPORT DNG=DONGLE_SUPPORT ISA=NO PCC=NO NET=NO RT=NO
sudo make install
sudo insmod pcan.ko
sudo modprobe pcan
sudo ./pcan_make_devices 2
