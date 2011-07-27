all: installed

TARBALL		= build/libphidget_2.1.7.20100621.tar.gz
TARBALL_URL 	= https://code.ros.org/svn/release/download/thirdparty/libphidget_2.1.7.20100621.tar.gz
UNPACK_CMD  	= tar zxf
SOURCE_DIR 	= build/libphidget-2.1.7.20100621
MD5SUM_FILE 	= libphidget_2.1.7.20100621.tar.gz.md5sum

include $(shell rospack find mk)/download_unpack_build.mk

installed: $(SOURCE_DIR)/unpacked
	cd $(SOURCE_DIR) && ./configure
	cd $(SOURCE_DIR) && make
	mkdir -p include/libphidgets && cp $(SOURCE_DIR)/phidget21.h include/libphidgets/
	mkdir -p lib && cp $(SOURCE_DIR)/.libs/libphidget21.* lib/
clean:
	rm -rf common $(SOURCE_DIR) $(TARBALL)
wipe: clean
	-rm -rf build
