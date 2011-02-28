all: installed

TARBALL 	= build/urg-0.8.11.zip
TARBALL_URL = https://code.ros.org/svn/release/download/thirdparty/urg-0.8.11.zip
UNPACK_CMD 	= unzip
SOURCE_DIR	= build/urg-0.8.11
MD5SUM_FILE = urg-0.8.11.zip.md5sum

include $(shell rospack find mk)/download_unpack_build.mk

installed: $(SOURCE_DIR)/unpacked
	mkdir -p include/libhokuyo_urg
	mkdir -p lib
	cd $(SOURCE_DIR) && ./configure && make $(ROS_PARALLEL_JOBS)
	cp $(SOURCE_DIR)/src/cpp/urg/.libs/liburg.so* lib
	cp $(SOURCE_DIR)/src/cpp/connection/.libs/liburg_connection.so* lib
	cp $(SOURCE_DIR)/src/cpp/connection/sdl/.libs/liburg_connection_sdl.so* lib
	cp $(SOURCE_DIR)/src/cpp/monitor/.libs/liburg_monitor.so* lib
	cp $(SOURCE_DIR)/src/cpp/system/.libs/liburg_system.so* lib
	cp $(SOURCE_DIR)/src/cpp/geometry/.libs/liburg_geometry.so* lib
	cp $(SOURCE_DIR)/src/cpp/common/.libs/liburg_common.so* lib
	cp $(SOURCE_DIR)/src/cpp/coordinate/.libs/liburg_coordinate.so* lib
	cp $(SOURCE_DIR)/include/cpp/* include/libhokuyo_urg/
	
clean:
	rm -rf src $(SOURCE_DIR) urg
wipe: clean
	rm -rf include
	rm -rf lib
	-rm -rf build

include $(shell rospack find mk)/cmake.mk
