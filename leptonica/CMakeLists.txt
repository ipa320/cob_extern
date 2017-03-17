cmake_minimum_required(VERSION 2.8.3)
project(leptonica)

find_package(catkin REQUIRED COMPONENTS)

catkin_destinations() # set-up destination variables
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION})

include(ExternalProject)
ExternalProject_Add(EP_${PROJECT_NAME}
    URL https://github.com/ipa320/thirdparty/raw/master/leptonica-1.68.tar.gz
    URL_MD5 5cd7092f9ff2ca7e3f3e73bfcd556403

    CONFIGURE_COMMAND "./configure"
    SOURCE_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src
    BUILD_IN_SOURCE 1
    BUILD_COMMAND make
        # copy headers to devel space (catkin does not like headers in source space)
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/src ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        # copy libs, set-up soname chain
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/src/.libs/liblept.so.2.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
        COMMAND ${CMAKE_COMMAND} -E create_symlink liblept.so.2.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so
        COMMAND ${CMAKE_COMMAND} -E create_symlink liblept.so.2.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so.2
    INSTALL_COMMAND ""
)

catkin_package(
    CFG_EXTRAS libleptonica-extras.cmake # catkin_package does not support artifacts in devel space
    EXPORTED_TARGETS EP_${PROJECT_NAME}
)

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
    FILES_MATCHING PATTERN "*.h"
)

install(PROGRAMS ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so
                 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so.2
                 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so.2.0.0
    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)
