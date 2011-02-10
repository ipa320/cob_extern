all: installed

GIT_DIR = oodl/
GIT_URL = git://github.com/janpaulus/BRICS_OODL.git

include $(shell rospack find mk)/git_checkout.mk

installed: $(GIT_DIR)
#	cd $(GIT_DIR) && cmake -DCMAKE_INSTALL_PREFIX:PATH=$(CURDIR)
#	cd $(GIT_DIR) && make
#	cp -rf $(GIT_DIR)/include $(CURDIR)/include
#	cp -rf $(GIT_DIR)/lib $(CURDIR)/lib

clean:
	cd $(GIT_DIR) && make clean
	rm -rf $(CURDIR)/lib $(CURDIR)/include $(CURDIR)/bin $(CURDIR)/build installed

wipe: clean
	rm -rf $(GIT_DIR)

include $(shell rospack find mk)/cmake.mk
