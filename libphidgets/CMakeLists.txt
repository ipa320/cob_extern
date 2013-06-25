cmake_minimum_required(VERSION 2.8.3)
project(libphidgets)


execute_process(COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball
          RESULT_VARIABLE _make_failed)
if(_make_failed)
  message(FATAL_ERROR "Building of libphidgets failed")
endif(_make_failed)

execute_process(COMMAND /bin/cp ${PROJECT_SOURCE_DIR}/lib/libphidget21.so.0  ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/libphidget21.so)
message(STATUS "Copying libs to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}")


# TODO: fill in what other packages will need to use this package
## DEPENDS: system dependencies of this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## INCLUDE_DIRS: 
## LIBRARIES: libraries you create in this project that dependent projects also need
catkin_package(
    DEPENDS libusb-dev
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS include
    LIBRARIES phidget21
)
