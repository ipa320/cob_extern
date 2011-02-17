all: installed

GIT_DIR = oodl/
GIT_URL = git://github.com/janpaulus/BRICS_OODL.git

include $(shell rospack find mk)/git_checkout.mk

installed: $(GIT_DIR)
	mkdir -p include/brics_oodl_scanner_libs/generic
	mkdir -p include/brics_oodl_scanner_libs/generic-laser-scanner
	mkdir -p include/brics_oodl_scanner_libs/sick-s300
	mkdir -p include/brics_oodl_scanner_libs/hokuyo-urg
	cp -rf $(GIT_DIR)/generic/*.hpp include/brics_oodl_scanner_libs/generic/
	cp -rf $(GIT_DIR)/generic-laser-scanner/*.hpp include/brics_oodl_scanner_libs/generic-laser-scanner/
	cp -rf $(GIT_DIR)/sick-s300/*.hpp include/brics_oodl_scanner_libs/sick-s300/
	cp -rf $(GIT_DIR)/hokuyo-urg/*.hpp include/brics_oodl_scanner_libs/hokuyo-urg/

clean:
	cd $(GIT_DIR) && make clean
	rm -rf $(CURDIR)/lib $(CURDIR)/include $(CURDIR)/bin $(CURDIR)/build installed

wipe: clean
	rm -rf $(GIT_DIR)

include $(shell rospack find mk)/cmake.mk
