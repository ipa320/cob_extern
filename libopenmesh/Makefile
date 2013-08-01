all: installed

VERSION = 2.3.1
TARBALL = build/OpenMesh-$(VERSION).tar.gz
TARBALL_URL = http://www.openmesh.org/fileadmin/openmesh-files/$(VERSION)/OpenMesh-$(VERSION).tar.gz
SOURCE_DIR = build/OpenMesh-$(VERSION)
UNPACK_CMD = tar xzf

include $(shell rospack find mk)/download_unpack_build.mk

installed: wiped $(SOURCE_DIR)/unpacked
	cd $(SOURCE_DIR) && mkdir -p build
	cd $(SOURCE_DIR)/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_APPS=OFF -DCMAKE_INSTALL_PREFIX=`rospack find libopenmesh`/common
	cd $(SOURCE_DIR)/build && make && make install
	touch installed

wiped: Makefile
	make wipe
	touch wiped

clean:
	-rm -rf common
	rm -f *~ installed

.PHONY : clean wipe

wipe: clean
	rm -rf build
