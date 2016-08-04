cmake_minimum_required(VERSION 2.8.3)
project(libconcorde_tsp_solver)

## Find catkin macros and libraries 
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

#test -e ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED ||
message(STATUS "Project source dir: ${PROJECT_SOURCE_DIR}")
add_custom_target(
    	build_libconcorde_tsp_solver ALL
    		COMMAND  cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball && touch ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED
    )


set(executables "concorde_tsp_solver")
foreach(executable ${executables})
	add_custom_target(
		copy_${executable} ALL
		COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/bin/concorde ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/${PROJECT_NAME}
   	COMMENT "Copying ${PROJECT_SOURCE_DIR}/common/bin/concorde to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/${PROJECT_NAME}"
	)
endforeach()

catkin_package(
	INCLUDE_DIRS
#		common/include
	LIBRARIES
#		libconcorde_tsp_solver
	CATKIN_DEPENDS
	DEPENDS
)

#include_directories(
#	common/include
#)

foreach(executable ${executables})
	add_executable(${executable} IMPORTED)
	add_dependencies(${executable} copy_${executable})
	add_dependencies(copy_${executable} build_libconcorde_tsp_solver)
	set_target_properties(${executable} PROPERTIES LINKER_LANGUAGE CXX)
endforeach()
set_target_properties(build_libconcorde_tsp_solver PROPERTIES LINKER_LANGUAGE CXX)


#############
## Install ##
#############
## Mark executables and/or libraries for installation
#install(TARGETS ${executables}
#	ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#	LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#	RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
#)

#install(DIRECTORY common/include
#	DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
#)
