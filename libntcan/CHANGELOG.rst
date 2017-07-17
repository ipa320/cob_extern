^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package libntcan
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0.6.11 (2017-07-17)
-------------------
* copy header and libs into devel space
* use EXPORTED_TARGETS
* final consistency
* migrated libntcan to catkin-native wrapping
* Contributors: ipa-fxm

0.6.10 (2016-12-08)
-------------------
* update changelog
* manually fix changelogs
* Contributors: ipa-fxm

0.6.9 (2016-10-24)
------------------

0.6.8 (2016-10-24)
------------------

0.6.7 (2016-10-20)
------------------

0.6.6 (2016-10-13)
------------------

0.6.5 (2016-10-10)
------------------

0.6.4 (2016-04-01)
------------------

0.6.3 (2015-08-31)
------------------

0.6.2 (2015-08-25)
------------------
* catkin_linting and make all build_depends depends only
* remove mainpage.dox
* fix trailing whitespace
* don't use CATKIN_GLOBAL\_* in CMakeLists
* Install Tag and catkin_package adaptations
* migrate to package format v2
* Contributors: ipa-mig

0.6.1 (2015-05-28)
------------------

0.6.0 (2014-09-16)
------------------

0.5.3 (2014-08-25)
------------------

0.5.2 (2014-03-20)
------------------
* Add missing find_package calls
* Contributors: Scott K Logan

0.5.1 (2014-03-19)
------------------
* add changelogs
* added install flags for libntcan
* gefrickel ported to cmake
* some more cmake stuff
* small change in include files
* fixing runtime linking errors by introducing library versions
* cob_extern is now cob_gefrickel :) did some cmake foo to be compatible to catkin
* Catkinized version of stack.
  Needs checking of build flags in cob_drivers.
  Also includes updating of libphidgets to 2.1.8 for newer boards.
* add CMakeLists.txt
* beautify manifest
* update manifests
* fixed make clean bug
* fixed make clean bug
* new package libmesasr
* cleanup in cob_extern
* renamed camera_axis to head_axis and platform to base
* update urdf to be compatible with ctrutle, add 64bit support for libntcan
* update documentation
* added esd_make_devices
* changed sdh to esd support
* renamed to general cob packages
* Contributors: Alexander Bubeck, abubeck, ipa-fmw