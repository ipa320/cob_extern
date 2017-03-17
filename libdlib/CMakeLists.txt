cmake_minimum_required(VERSION 2.8.3)
project(libdlib)

find_package(catkin REQUIRED)

catkin_destinations() # set-up destination variables
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION})

set(VERSION 18.17)

include(ExternalProject)
ExternalProject_Add(EP_${PROJECT_NAME}
    URL https://github.com/ipa320/thirdparty/raw/master/dlib-${VERSION}.tar.bz2
    URL_MD5 249164604423590c3f1682ab1af66ca0

    SOURCE_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src
    BINARY_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-build
    
    CONFIGURE_COMMAND ${CMAKE_COMMAND} ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/dlib
    BUILD_COMMAND ${CMAKE_COMMAND} --build . --config Release
        # copy headers to devel space (catkin does not like headers in source space)
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/dlib ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        # copy libs, set-up soname chain
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-build/libdlib.a ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
    INSTALL_COMMAND ""
)

catkin_package(
    CFG_EXTRAS libdlib-extras.cmake # catkin_package does not support artifacts in devel space
    EXPORTED_TARGETS EP_${PROJECT_NAME}
)

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
    FILES_MATCHING PATTERN "*.h"
)

install(FILES ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libdlib.a
    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)
