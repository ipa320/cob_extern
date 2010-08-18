all: libsiftfast

SVN_DIR = build/libsiftfast_svn
SVN_URL = https://libsift.svn.sourceforge.net/svnroot/libsift/trunk
include $(shell rospack find mk)/svn_checkout.mk

libsiftfast: $(SVN_DIR)
	#update
	svn up $(SVN_DIR)
	
	# build
	cd $(SVN_DIR) && make
	
	# copy to common
	mkdir -p common
	mkdir -p common/lib
	mkdir -p common/include
	mkdir -p common/include/libsiftfast
	cp $(SVN_DIR)/build/*.so* common/lib
	cp $(SVN_DIR)/*.h common/include/libsiftfast

clean:
	rm -rf common $(SVN_DIR)
wipe: clean
	-rm -rf build
