## Hardware Requirements

You can use this package with a PCAN-USB or a PCAN-PCI adapter from
<http://www.peak-system.com>.

## Installation

First build the library with 

```
rosdep install libpcan
rosmake libpcan
```

 Afternwards
install the module with 

```
roscd libpcan
sudo ./install_pcan.sh
```



After this procedure the driver is installed for your system (and your
kernel so you have to repeat the procedure once your kernel has
changed). To activate the driver you have to restart the system or if
you want to avoid that manual load the driver with:


```
sudo modprobe pcan
```

 After restart the driver will be activated
automatically.

You can verify the result with the command: 

```
ls -l /dev/pcan*
```



If you need additional documentation you can read the manual :
[Pcan driver for linux](http://www.peak-system.com/fileadmin/media/linux/files/PCAN%20Driver%20for%20Linux_eng_7.1.pdf)
