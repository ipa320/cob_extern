all: libphidget

TARBALL = build/libphidget_2.1.7.20100621.tar.gz
TARBALL_URL = http://www.phidgets.com/downloads/libraries/libphidget_2.1.7.20100621.tar.gz
SOURCE_DIR = build/libphidget-2.1.7.20100621
include $(shell rospack find mk)/download_unpack_build.mk

libphidget:
	cd $(SOURCE_DIR) && ./configure
	cd $(SOURCE_DIR) && make
	cd $(SOURCE_DIR) && sudo make install
clean:
	rm -rf common $(SOURCE_DIR) $(TARBALL)
wipe: clean
	-rm -rf build
