ifeq ($(shell uname -m),i686)
	FILENAME=libmesasr-dev-1.0.14-653.i386.deb
else
	FILENAME=libmesasr-dev-1.0.14-653.amd64.deb
endif

all: libmesasr

libmesasr:
	wget --tries=10 http://www.mesa-imaging.ch/customer/driver/$(FILENAME)
	mkdir -p TMP
	dpkg-deb -x $(FILENAME) TMP
	mkdir -p common/lib/
	cp TMP/usr/lib/libmesasr.so* common/lib/
	mkdir -p common/include/libmesasr/
	cp TMP/usr/include/* common/include/libmesasr/
	rm $(FILENAME)
	rm -r TMP

clean:
	rm -rf common
wipe: clean
	-rm -rf common

