cmake_minimum_required(VERSION 3.0.2)
project(libphidgets)

find_package(catkin REQUIRED COMPONENTS)

catkin_destinations() # set-up destination variables
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION})

include(ExternalProject)
ExternalProject_Add(EP_${PROJECT_NAME}
    URL https://www.phidgets.com/downloads/phidget21/libraries/linux/libphidget/libphidget_2.1.9.20190409.tar.gz
    URL_MD5 1149757d0b0483520c6b7525d2d62f7d

    CONFIGURE_COMMAND ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/configure CFLAGS=-Wno-incompatible-pointer-types\ -Wno-deprecated-declarations\ -Wno-format-truncation
    SOURCE_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src
    BUILD_IN_SOURCE 1
    PATCH_COMMAND touch ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/Makefile.in # avoid broken re-generation from old Makefile.am with CMP0135
    BUILD_COMMAND make
        # copy headers to devel space (catkin does not like headers in source space)
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/phidget21.h ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        # copy libs, set-up soname chain
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/.libs/libphidget21.so.0.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
        COMMAND ${CMAKE_COMMAND} -E create_symlink libphidget21.so.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libphidget21.so
        COMMAND ${CMAKE_COMMAND} -E create_symlink libphidget21.so.0.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libphidget21.so.0
    INSTALL_COMMAND ""
)

catkin_package(
    CFG_EXTRAS libphidgets-extras.cmake # catkin_package does not support artifacts in devel space
    EXPORTED_TARGETS EP_${PROJECT_NAME}
)

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)

install(PROGRAMS ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libphidget21.so
                 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libphidget21.so.0
                 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libphidget21.so.0.0.0
    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)
