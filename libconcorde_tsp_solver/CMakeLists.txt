cmake_minimum_required(VERSION 2.8.3)
project(libconcorde_tsp_solver)

find_package(catkin REQUIRED)

catkin_destinations() # set-up destination variables
file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION})

# check if qsopt has been installed
find_package(libqsopt)
message("libqsopt_FOUND = ${libqsopt_FOUND}")
message("libqsopt_INCLUDE_DIRS = ${libqsopt_INCLUDE_DIRS}")
LIST(GET libqsopt_INCLUDE_DIRS 0 LIBQSOPT_INCLUDE_PATH)
message("using LIBQSOPT_INCLUDE_PATH = ${LIBQSOPT_INCLUDE_PATH}")
message("libqsopt_LIBRARIES = ${libqsopt_LIBRARIES}")
#!!Qsopt is neccessary to solve TSPs with more than 10 nodes!!
# you need to have a qsopt.a and a qsopt.h in the source folder and you have to use an absolute path to link it with Concorde
if(libqsopt_FOUND)
  set(QSOPT_INSTALLED "true")
  set(QSOPT_CONFIGURE mkdir -p ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/libqsopt &&
                      ${CMAKE_COMMAND} -E copy_if_different ${LIBQSOPT_INCLUDE_PATH}/libqsopt/qsopt.h ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/libqsopt &&
                      ${CMAKE_COMMAND} -E copy_if_different ${libqsopt_LIBRARIES} ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/libqsopt &&
                      ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/configure --with-qsopt=${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/libqsopt)
  message("QSOPT FOUND , using install configure command: ${QSOPT_CONFIGURE}")
else()
  message(WARNING "+++++++++++ QSOPT NOT INSTALLED, ONLY TSPs WITH UP TO 10 NODES SOLVABLE +++++++++++")
  set(QSOPT_INSTALLED "false")
  set(QSOPT_CONFIGURE "")
endif()

include(ExternalProject)
ExternalProject_Add(EP_${PROJECT_NAME}
    URL https://github.com/ipa320/thirdparty/raw/master/concorde-tsp-solver-20031219.tar.gz
    URL_MD5 fba5435ca1fd01f9da081fe5232a7203

    CONFIGURE_COMMAND "./configure"
    SOURCE_DIR ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src
    BUILD_IN_SOURCE 1
    BUILD_COMMAND
      COMMAND ${QSOPT_CONFIGURE}  # use special configuration when building with qsopt
      COMMAND make concorde.a concorde.h
      # copy headers to devel space (catkin does not like headers in source space)
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/concorde.h ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}
      # copy libs, set-up soname chain
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${PROJECT_BINARY_DIR}/${PROJECT_NAME}-src/concorde.a ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
    INSTALL_COMMAND ""
)

catkin_package(
    CFG_EXTRAS libconcorde_tsp_solver-extras.cmake # catkin_package does not support artifacts in devel space
    EXPORTED_TARGETS EP_${PROJECT_NAME}
)

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)

install(FILES ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/concorde.a
    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)
