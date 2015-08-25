cmake_minimum_required(VERSION 2.8.3)
project(libpcan)

find_package(catkin REQUIRED COMPONENTS mk rospack)

catkin_package(
    INCLUDE_DIRS common/include
    LIBRARIES pcan
)

include_directories(common/include ${catkin_INCLUDE_DIRS})

add_custom_target(
    build_libpcan ALL
    COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball
)

add_custom_target(
    copy_pcan ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/common/lib/libpcan.so  ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/
)

add_custom_target(
    copy_pcan0 ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/common/lib/libpcan.so.0  ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/
)

add_custom_target(
    copy_pcan06 ALL
    COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/common/lib/libpcan.so.0.6  ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/
)
message(STATUS "Copying libs to ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}")


add_library(pcan SHARED)
set_target_properties(pcan PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(pcan copy_pcan)
add_dependencies(pcan copy_pcan0)
add_dependencies(pcan copy_pcan06)
add_dependencies(copy_pcan build_libpcan)
add_dependencies(copy_pcan0 build_libpcan)
add_dependencies(copy_pcan06 build_libpcan)

install(TARGETS pcan
    ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
    LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
    RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
)

install(PROGRAMS common/lib/libpcan.so common/lib/libpcan.so.0 common/lib/libpcan.so.0.6
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

install(DIRECTORY common/include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)
