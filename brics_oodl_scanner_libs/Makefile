all: installed

TARBALL     = build/janpaulus-BRICS_OODL-e08295d.tar.gz
TARBALL_URL = https://code.ros.org/svn/release/download/thirdparty/janpaulus-BRICS_OODL-e08295d.tar.gz
UNPACK_CMD  = tar zxf
SOURCE_DIR  = build/janpaulus-BRICS_OODL-e08295d
MD5SUM_FILE = janpaulus-BRICS_OODL-e08295d.tar.gz.md5sum

include $(shell rospack find mk)/download_unpack_build.mk

installed: $(SOURCE_DIR)/unpacked
	mkdir -p include/brics_oodl_scanner_libs/generic
	mkdir -p include/brics_oodl_scanner_libs/generic-laser-scanner
	mkdir -p include/brics_oodl_scanner_libs/sick-s300
	mkdir -p include/brics_oodl_scanner_libs/hokuyo-urg
	cp -rf $(SOURCE_DIR)/generic/*.hpp include/brics_oodl_scanner_libs/generic/
	cp -rf $(SOURCE_DIR)/generic-laser-scanner/*.hpp include/brics_oodl_scanner_libs/generic-laser-scanner/
	cp -rf $(SOURCE_DIR)/sick-s300/*.hpp include/brics_oodl_scanner_libs/sick-s300/
	cp -rf $(SOURCE_DIR)/hokuyo-urg/*.hpp include/brics_oodl_scanner_libs/hokuyo-urg/

clean:
	-cd $(SOURCE_DIR) && make clean
	rm -rf $(CURDIR)/lib $(CURDIR)/include $(CURDIR)/bin build installed

wipe: clean
	rm -rf $(SOURCE_DIR)
	rm -rf build
	rm -rf include

include $(shell rospack find mk)/cmake.mk
