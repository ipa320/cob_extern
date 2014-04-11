cmake_minimum_required(VERSION 2.8.3)
project(libpcan)

find_package(catkin REQUIRED COMPONENTS rosbuild roslib mk rosbuild rospack)

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

catkin_package(
    DEPENDS
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS common/include common/include/libpcan
    LIBRARIES pcan
)


include_directories(${catkin_INCLUDE_DIRS})
add_library(pcan SHARED)
set_target_properties(pcan PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(pcan copy_pcan)
add_dependencies(pcan copy_pcan0)
add_dependencies(pcan copy_pcan06)
add_dependencies(copy_pcan build_libpcan)
add_dependencies(copy_pcan0 build_libpcan)
add_dependencies(copy_pcan06 build_libpcan)

install(PROGRAMS common/lib/libpcan.so common/lib/libpcan.so.0 common/lib/libpcan.so.0.6
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

install(FILES common/include/libpcan/pcan.h common/include/libpcan/libpcan.h 
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)  

install(DIRECTORY common/include/
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)

install(DIRECTORY common/include/libpcan
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)
