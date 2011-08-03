all: installed

TARBALL = build/libcvd-20100511.tar.gz
TARBALL_URL = http://www.edwardrosten.com/cvd/libcvd-20100511.tar.gz
SOURCE_DIR = build/libcvd-20100511
#MD5SUM_FILE = libtoon.tar.gz.md5sum

include $(shell rospack find mk)/download_unpack_build.mk

installed: $(SOURCE_DIR)/unpacked
	# build
	cd $(SOURCE_DIR) && ./configure
	cd $(SOURCE_DIR)/cvd && patch < ../../../utility.patch
	cd $(SOURCE_DIR) && make
	
	# copy to common
	mkdir -p common
	mkdir -p common/include
	mkdir -p common/include/libcvd
	cp -r $(SOURCE_DIR)/cvd/* common/include/libcvd
	#cd common/include && ln -sf libcvd cvd
	mkdir -p common/lib
	#cp -r
clean:
	rm -rf common $(SOURCE_DIR) $(TARBALL)
wipe: clean
	-rm -rf build
