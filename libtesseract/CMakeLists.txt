cmake_minimum_required(VERSION 2.8.3)
project(libtesseract)

find_package(catkin REQUIRED)
find_package(leptonica REQUIRED)

catkin_destinations() # set-up destination variables
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION})

message("LIBS: ${CATKIN_GLOBAL_LIB_DESTINATION}")
include(ExternalProject)
ExternalProject_Add(EP_${PROJECT_NAME}
    DEPENDS ${leptonica_EXPORTED_TARGETS}
    URL https://github.com/ipa320/thirdparty/raw/master/tesseract-ocr-rev722.tar.gz
    URL_MD5 18eb3c2076d2708356212dc6e11ecea4

    UPDATE_COMMAND "./autogen.sh"
    #PATCH_COMMAND patch < ${PROJECT_SOURCE_DIR}/tesseract.patch
    CONFIGURE_COMMAND env LIBLEPT_HEADERSDIR="${leptonica_INCLUDE_DIRS}" ./configure --with-extra-libraries="${CATKIN_DEVEL_PREFIX}/lib"
    SOURCE_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src
    BUILD_IN_SOURCE 1
    BUILD_COMMAND make
        ## copy headers to devel space (catkin does not like headers in source space)
        #COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
        ## copy libs, set-up soname chain
        #COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/src/.libs/liblept.so.2.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
        #COMMAND ${CMAKE_COMMAND} -E create_symlink liblept.so.2.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so
        #COMMAND ${CMAKE_COMMAND} -E create_symlink liblept.so.2.0.0 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so.2
    INSTALL_COMMAND ""
)

catkin_package(
    CFG_EXTRAS libtesseract-extras.cmake # catkin_package does not support artifacts in devel space
    EXPORTED_TARGETS EP_${PROJECT_NAME}
    CATKIN_DEPENDS leptonica
)

#install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
    #DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
    #FILES_MATCHING PATTERN "*.h"
#)

#install(PROGRAMS ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so
                 #${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so.2
                 #${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/liblept.so.2.0.0
    #DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#)
