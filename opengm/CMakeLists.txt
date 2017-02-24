cmake_minimum_required(VERSION 2.8.3)
project(opengm)

## Find catkin macros and libraries 
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
add_custom_target(
    	build_opengm ALL
		COMMAND  cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball 
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


#############
## Install ##
#############
# header-only library, so only install header files
install(DIRECTORY common/include/${PROJECT_NAME}/
	DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)
