^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package libconcorde_tsp_solver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
