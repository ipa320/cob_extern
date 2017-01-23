cmake_minimum_required(VERSION 2.8.3)
project(libconcorde_tsp_solver)

## Find catkin macros and libraries 
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)
find_package(libqsopt)

catkin_package(
	INCLUDE_DIRS
		common/include
	LIBRARIES
		concorde
	CATKIN_DEPENDS
	DEPENDS
)

# check if qsopt has been installed
if(EXISTS ${libqsopt_INCLUDE_DIRS}/NOT_INSTALLED)
   message(WARNING "+++++++++++ QSOPT NOT INSTALLED, ONLY TSPs WITH UP TO 10 NODES SOLVABLE +++++++++++")
   set(QSOPT_INSTALLED "false")
else()
   set(QSOPT_INSTALLED "true")
endif()

message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
message(STATUS "qsopt include dir: ${libqsopt_INCLUDE_DIRS}") # find required absolut path to qsopt and set it as a variable when calling Makefile.tarball s.t. it can access it
add_custom_target(
    	build_libconcorde_tsp_solver ALL
    		COMMAND export QSOPT_INC=${libqsopt_INCLUDE_DIRS} && export QSOPT_INST=${QSOPT_INSTALLED} && cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball
		COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/concorde.a  ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/concorde.a
    )



add_custom_target(
	copy_concorde_tsp_solver ALL
	COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/bin/concorde ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/${PROJECT_NAME}
	COMMENT "Copying ${PROJECT_SOURCE_DIR}/common/bin/concorde to ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/${PROJECT_NAME}"
)

include_directories(
	common/include
)

add_library(concorde SHARED)
add_executable(concorde_tsp_solver IMPORTED)
add_dependencies(concorde_tsp_solver copy_concorde_tsp_solver)
add_dependencies(copy_concorde_tsp_solver build_libconcorde_tsp_solver)
set_target_properties(concorde_tsp_solver PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(build_libconcorde_tsp_solver PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(concorde PROPERTIES LINKER_LANGUAGE CXX)


#############
## Install ##
#############
## Mark executables and/or libraries for installation
install(TARGETS concorde
	ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
	LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
	RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
)

install(PROGRAMS common/lib/concorde.a
	DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

install(DIRECTORY common/include/${PROJECT_NAME}/
	DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)
