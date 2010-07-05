all: libwm4

ZIPFILE = WildMagic4p10.zip
ZIPFILE_URL = http://www.geometrictools.com/Downloads/$(ZIPFILE)
SOURCE_DIR = build

libwm4:
	# get zip-file
	mkdir -p $(SOURCE_DIR)
	cd $(SOURCE_DIR) && wget $(ZIPFILE_URL) -N
	# unzip
	cd $(SOURCE_DIR); unzip -n $(ZIPFILE)
	# make
	cd $(SOURCE_DIR)/GeometricTools/WildMagic4; make -f makefile.wm4 CFG=Release SYS=linux GRF=OpenGL
	# move lib and header to export path (common)
	mkdir -p common
	mkdir -p common/lib
	mkdir -p common/include
	mkdir -p common/include/libwm4
	cp $(SOURCE_DIR)/GeometricTools/WildMagic4/SDK/Library/Release/lib* common/lib
	cp $(SOURCE_DIR)/GeometricTools/WildMagic4/SDK/Include/* common/include/libwm4
	mkdir -p common/include/Wm4
	cp $(SOURCE_DIR)/GeometricTools/WildMagic4/SDK/Include/* common/include/Wm4
clean:
	rm -rf common $(SOURCE_DIR)
wipe: clean
	-rm -rf $(SOURCE_DIR)
	
