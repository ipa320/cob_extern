cmake_minimum_required(VERSION 2.8.3)
project(libpcan)

find_package(catkin REQUIRED)

add_custom_target(
    build_libpcan ALL
    COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball)


add_custom_target(
    copy_pcan ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/common/lib/libpcan.so  ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/)
add_custom_target(
    copy_pcan0 ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/common/lib/libpcan.so.0  ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/
    )
add_custom_target(
    copy_pcan06 ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/common/lib/libpcan.so.0.6  ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/
    )
message(STATUS "Copying libs to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}")

add_library(pcan SHARED)
set_target_properties(pcan PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(pcan copy_pcan)
add_dependencies(pcan copy_pcan0)
add_dependencies(pcan copy_pcan06)
add_dependencies(copy_pcan build_libpcan)
add_dependencies(copy_pcan0 build_libpcan)
add_dependencies(copy_pcan06 build_libpcan)

# TODO: fill in what other packages will need to use this package
## DEPENDS: system dependencies of this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## INCLUDE_DIRS:
## LIBRARIES: libraries you create in this project that dependent projects also need
catkin_package(
    DEPENDS linux-headers-generic libpopt-dev
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS common/include common/include/libpcan
    LIBRARIES pcan
)
