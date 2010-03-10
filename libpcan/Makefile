all: libpcan

TARBALL = build/peak-linux-driver-6.11.tar.gz
TARBALL_URL = http://p103112.typo3server.info/fileadmin/media/linux/files/peak-linux-driver.6.11.tar.gz
SOURCE_DIR = build/peak-linux-driver-6.11
KERNEL_VER=/usr/src/linux-headers-"`uname -r`"
include $(shell rospack find mk)/download_unpack_build.mk

libpcan: $(SOURCE_DIR)/unpacked
	# build
	cd $(SOURCE_DIR) && make KERNEL_LOCATION=$(KERNEL_VER)
	# copy to common
	mkdir -p common
	mkdir -p common/lib
	mkdir -p common/include
	mkdir -p common/include/libpcan	
	cp $(SOURCE_DIR)/lib/*.so* common/lib
	cp common/lib/libpcan.so common/lib/libpcan.so.0
	cp $(SOURCE_DIR)/lib/*.h common/include/libpcan
	cp $(SOURCE_DIR)/driver/*.h common/include/libpcan
clean:
	rm -rf common $(SOURCE_DIR) $(TARBALL)
wipe: clean
	-rm -rf build
