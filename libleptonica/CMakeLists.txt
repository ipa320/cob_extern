cmake_minimum_required(VERSION 2.8.3)
project(libleptonica)

find_package(catkin REQUIRED COMPONENTS mk roslib rospack)

message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
add_custom_target(
  build_lept ALL
  COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball
)

add_custom_target(
  copy_lept ALL
  COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/lib/liblept.so ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}
    COMMENT "Copying ${PROJECT_SOURCE_DIR}/lib/liblept.so to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}"
)

catkin_package(
  INCLUDE_DIRS
    include
  LIBRARIES
    lept
)

include_directories(
  include
)

add_library(lept SHARED)
set_target_properties(lept PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(copy_lept build_lept)
add_dependencies(lept copy_lept)

#############
## Install ##
#############
install(TARGETS lept
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY include
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)
