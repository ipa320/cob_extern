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
    		COMMAND  cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball && touch ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED 
    )

catkin_package(
	INCLUDE_DIRS
		common/include
	LIBRARIES
	CATKIN_DEPENDS
	DEPENDS
)

include_directories(
	common/include
)

#foreach(library ${libraries})
#	add_library(${library} SHARED)
#	add_dependencies(${library} copy_${library})
#	add_dependencies(copy_${library} build_dlib187)
#	set_target_properties(${library} PROPERTIES LINKER_LANGUAGE CXX)
#endforeach()
set_target_properties(build_dlib187 PROPERTIES LINKER_LANGUAGE CXX)


#############
## Install ##
#############
## Mark executables and/or libraries for installation
#install(TARGETS dlib
#	ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#	LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#	RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
#)

install(DIRECTORY common/include/${PROJECT_NAME}/
	DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)
