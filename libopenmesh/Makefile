all: installed

VERSION = 2.4
TARBALL = build/OpenMesh-$(VERSION).tar.gz
TARBALL_URL = http://www.openmesh.org/fileadmin/openmesh-files/$(VERSION)/OpenMesh-$(VERSION).tar.gz
SOURCE_DIR = build/OpenMesh-$(VERSION)
UNPACK_CMD = tar xzf

include $(shell rospack find mk)/download_unpack_build.mk

installed: $(SOURCE_DIR)/unpacked
	cd $(SOURCE_DIR) && mkdir -p build
	cd $(SOURCE_DIR)/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_APPS=OFF -DCMAKE_INSTALL_PREFIX=`rospack find libopenmesh`/common
	cd $(SOURCE_DIR)/build && make && make install

clean:
	rm -rf common

wipe: clean
	rm -rf build

include $(shell rospack find mk)/cmake.mk
