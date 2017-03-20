cmake_minimum_required(VERSION 2.8.3)
project(libpcan)

find_package(catkin REQUIRED COMPONENTS)

catkin_destinations() # set-up destination variables
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION})

include(ExternalProject)
ExternalProject_Add(EP_${PROJECT_NAME}
    URL http://www.peak-system.com/fileadmin/media/linux/files/peak-linux-driver-8.3.tar.gz
    URL_MD5 d8d58223c1b1c03b891aa43763fec2cb

    CONFIGURE_COMMAND ""
    # patch include to bundle in one directory
    PATCH_COMMAND sed -i "/#include <pcan.h>/c\\#include \"pcan.h\"" ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/lib/libpcan.h
    SOURCE_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src
    BUILD_IN_SOURCE 1
    BUILD_COMMAND make -C lib libpcan.so.0.6
        # copy headers to devel space (catkin does not like headers in source space)
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/lib/libpcan.h ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/driver/pcan.h ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        # copy libs, set-up soname chain
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/lib/libpcan.so.0.6 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
        COMMAND ${CMAKE_COMMAND} -E create_symlink libpcan.so.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libpcan.so
        COMMAND ${CMAKE_COMMAND} -E create_symlink libpcan.so.0.6 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libpcan.so.0
    INSTALL_COMMAND ""
)

catkin_package(
    CFG_EXTRAS libpcan-extras.cmake # catkin_package does not support artifacts in devel space
    EXPORTED_TARGETS EP_${PROJECT_NAME}
)

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)

install(PROGRAMS ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libpcan.so
                 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libpcan.so.0
                 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libpcan.so.0.6
    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

