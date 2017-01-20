cmake_minimum_required(VERSION 2.8.3)
project(libdlib)

## Find catkin macros and libraries 
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

#test -e ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED ||
message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
add_custom_target(
    	build_dlib187 ALL
    		COMMAND  cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball
		 COMMAND cmake -E copy ${PROJECT_SOURCE_DIR}/common/lib/libdlib.a  ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/
    )

catkin_package(
	INCLUDE_DIRS
		common/include
	LIBRARIES
		Dlib
	CATKIN_DEPENDS
	DEPENDS
)

include_directories(
	common/include
)

add_library(Dlib SHARED)
add_dependencies(Dlib build_dlib187)
set_target_properties(Dlib PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(build_dlib187 PROPERTIES LINKER_LANGUAGE CXX)


#############
## Install ##
#############
install(PROGRAMS common/lib/libdlib.a
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

install(DIRECTORY common/include/${PROJECT_NAME}/
	DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)
