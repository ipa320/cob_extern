all: installed

TARBALL = build/libtoon.tar.gz
TARBALL_URL = https://code.ros.org/svn/release/download/thirdparty/libtoon.tar.gz
SOURCE_DIR = build/libtoon
MD5SUM_FILE = libtoon.tar.gz.md5sum

include $(shell rospack find mk)/download_unpack_build.mk

installed: wipe $(SOURCE_DIR)/unpacked
	# build
	cd $(SOURCE_DIR) && ./configure
	cd $(SOURCE_DIR)/internal && patch -N < ../../../size_mismatch.patch
	
	# copy to common
	mkdir -p common
	mkdir -p common/include
	mkdir -p common/include/libtoon
	cp -r $(SOURCE_DIR)/* common/include/libtoon
	cd common/include && ln -sf libtoon TooN
	touch ROS_NOBUILD
clean:
	rm -rf common $(SOURCE_DIR) $(TARBALL)
	rm -rf ROS_NOBUILD
wipe: clean
	-rm -rf build
