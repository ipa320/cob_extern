^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package libconcorde_tsp_solver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

0.6.12 (2018-01-07)
-------------------
* Merge pull request `#92 <https://github.com/ipa320/cob_extern/issues/92>`_ from ipa320/indigo_release_candidate
  Indigo release candidate
* Merge pull request `#91 <https://github.com/ipa320/cob_extern/issues/91>`_ from ipa-rmb/indigo_dev
  fixed libqsopt and libconcorde_tsp_solver
* fixed libqsopt and libconcorde_tsp_solver
* Merge pull request `#90 <https://github.com/ipa320/cob_extern/issues/90>`_ from ipa-rmb/concorde-patch
  added missing binary in CMakeLists of libconcorde_tsp_solver
* changed PROGRAMS to FILES for installing concorde.a
* added missing binary in CMakeLists of libconcorde_tsp_solver
* Contributors: Felix Messmer, Richard Bormann, ipa-fez

0.6.11 (2017-07-17)
-------------------
* fix include_dirs in cmake_extras
* use EXPORTED_TARGETS
* migrated libconcorde_tsp_solver to catkin-native wrapping
* license workarounds
* style check
* updated install tags for bins in libconcorde_tsp_solver
* minor bugfix in libconcorde_tsp_solver regarding installation of executable
* changed libopengm to opengm, because of internal includes of opengm-library that expect headers to be in include/opengm
* continued workaround before merge with ipa320
* catkin workaround before merge with ipa320
* updated package.xml for libqsopt and libconcorde-tsp-solver
* concorde tests if architecture is supported for qsopt
* absolut path to qsopt found by cmake
* working on libconcorde_tsp_solver to find libqsopt
* separated Qsopt and Concorde into two packages
* Contributors: ipa-fxm, ipa-rmb-fj
