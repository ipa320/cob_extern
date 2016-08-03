cmake_minimum_required(VERSION 2.8.3)
project(libopengm)

## Find catkin macros and libraries 
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

#test -e ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED ||
message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
add_custom_target(
    	build_opengm ALL
    		COMMAND  cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball && touch ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED 
    )
message(STATUS "Done Tarball")

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


#############
## Install ##
#############
## Mark executables and/or libraries for installation
#install(TARGETS opengm
#	ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#	LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#	RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
#)

install(DIRECTORY common/include
	DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)
