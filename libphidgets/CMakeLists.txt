cmake_minimum_required(VERSION 2.8.3)
project(libphidgets)

find_package(catkin REQUIRED)

add_custom_target(
    build_phidget21 ALL
    COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.phidgets)

add_custom_target(
    copy_phidget21 ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/lib/libphidget21.so.0  ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/libphidget21.so
)
add_custom_target(
    copy_phidget210 ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/lib/libphidget21.so.0  ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/libphidget21.so.0
)
message(STATUS "Copying libs to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}")

add_library(phidget21 SHARED)
set_target_properties(phidget21 PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(copy_phidget21 build_phidget21)
add_dependencies(copy_phidget210 build_phidget21)
add_dependencies(phidget21 copy_phidget21)
add_dependencies(phidget21 copy_phidget210)



# TODO: fill in what other packages will need to use this package
## DEPENDS: system dependencies of this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## INCLUDE_DIRS: 
## LIBRARIES: libraries you create in this project that dependent projects also need
catkin_package(
    DEPENDS libusb-dev
    INCLUDE_DIRS include
    LIBRARIES phidget21
)


## Mark executables and/or libraries for installation
#nstall(TARGETS 
# ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
# LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
# RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
#
