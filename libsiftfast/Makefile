all: libsiftfast

INSTALL_DIR=`rospack find libsiftfast`
SVN_DIR = libsiftfast_svn
SVN_URL = https://libsift.svn.sourceforge.net/svnroot/libsift/trunk
include $(shell rospack find mk)/svn_checkout.mk

.PHONY: libsiftfast

build: SVN_UP libsiftfast

BOOST_INCLUDE_DIRS=$(shell rosboost-cfg --include_dirs)
BOOST_LIBRARY_DIRS=$(shell rosboost-cfg --lib_dirs)

BUILDDIR=$(shell if [ $(DEBUG) ]; then echo builddebug; else echo build; fi)
BUILDDIR=$(shell if [ $(DEBUG) ]; then echo builddebug; else echo build; fi)
CMAKE_BUILD_TYPE=$(shell if [ $(DEBUG) ]; then echo Debug; else echo RelWithDebInfo; fi)

libsiftfast: $(SVN_DIR)
	cd $(SVN_DIR) && svn up && mkdir -p $(BUILDDIR) && cd $(BUILDDIR) && BOOST_INCLUDEDIR=$(BOOST_INCLUDE_DIRS) BOOST_LIBRARYDIR=$(BOOST_LIBRARY_DIRS) cmake -DCMAKE_INSTALL_PREFIX=$(INSTALL_DIR) -DCMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE) .. && make $(ROS_PARALLEL_JOBS) install

clean:
	cd $(INSTALL_DIR) && make -C $(SVN_DIR) clean

wipe: clean
	cd $(INSTALL_DIR) && rm -rf $(SVN_DIR) include lib share


