cmake_minimum_required(VERSION 2.8.3)
project(libleptonica)

find_package(catkin REQUIRED)

message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
add_custom_target(
  build_leptonica ALL
  COMMAND test -e ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED || (cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball && touch ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED)
)

set(libraries "lept")
foreach(library ${libraries})
  add_custom_target(
    copy_${library} ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/lib/lib${library}.so ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}
      COMMENT "Copying ${PROJECT_SOURCE_DIR}/lib/lib${library}.so to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}"
  )
endforeach()

catkin_package(
  INCLUDE_DIRS
    include
  LIBRARIES
    lept
)

include_directories(
  include
)

foreach(library ${libraries})
  add_library(${library} SHARED)
  add_dependencies(${library} copy_${library})
  add_dependencies(copy_${library} build_leptonica)
  set_target_properties(${library} PROPERTIES LINKER_LANGUAGE CXX)
endforeach()
set_target_properties(build_leptonica PROPERTIES LINKER_LANGUAGE CXX)


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