cmake_minimum_required(VERSION 2.8.3)
project(libtesseract)

find_package(catkin REQUIRED COMPONENTS
  libleptonica
  mk
  roslib
  rospack
)

message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
add_custom_target(
  build_tesseract ALL
  COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball
)

add_custom_target(
  copy_tesseract ALL
  COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/lib/libtesseract.so ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}
    COMMENT "Copying ${PROJECT_SOURCE_DIR}/lib/libtesseract.so to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}"
)

catkin_package(
  INCLUDE_DIRS
    include
  LIBRARIES
    tesseract
)

include_directories(
  include
)

add_library(tesseract SHARED)
set_target_properties(tesseract PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(copy_tesseract build_tesseract)
add_dependencies(tesseract copy_tesseract)

#############
## Install ##
#############
install(TARGETS tesseract
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY include
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)
