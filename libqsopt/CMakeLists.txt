cmake_minimum_required(VERSION 2.8.3)
project(libqsopt)

## Find catkin macros and libraries 
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED)

find_program(CMAKE_DPKG dpkg /bin /usr/bin /usr/local/bin) 
if(CMAKE_DPKG)
  exec_program(dpkg ARGS --print-architecture OUTPUT_VARIABLE CMAKE_DPKG_ARCH)
  if(CMAKE_DPKG_ARCH MATCHES "amd64")
    message(STATUS "+++++++++++++++++ DETECTED 64 bit +++++++++++++++++")
    set(MYARCH "Qsopt_64")
    set(SUPPORTED "true")
  elseif(CMAKE_DPKG_ARCH MATCHES "i386")
    message(STATUS "+++++++++++++++++ DETECTED 32 bit +++++++++++++++++")
    set(MYARCH "Qsopt_32")
    set(SUPPORTED "true")
  else()
    message(WARNING "+++++++++++++++++ UNSUPPORTED ARCHITECTURE, UNABLE TO USE QSOPT +++++++++++++++++")
    set(SUPPORTED "false")
  endif()
endif()

catkin_package(
   INCLUDE_DIRS
      common/include
   LIBRARIES
)

include_directories(
  common/include
  ${catkin_INCLUDE_DIRS}
)

if(SUPPORTED MATCHES "true")
   message(STATUS "Copying ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/qsopt.a to ${PROJECT_SOURCE_DIR}/common/include/libqsopt/qsopt.a")

   # Qsopt expects qsopt.a to be in the same directory as qsopt.h --> static library, when using in another package one has to provide an absolut path to it
   add_custom_target(
    	   build_qsopt ALL
	   COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/qsopt.a ${PROJECT_SOURCE_DIR}/common/include/libqsopt
	   COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/qsopt.h ${PROJECT_SOURCE_DIR}/common/include/libqsopt && touch ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_SHARE_DESTINATION}/${PROJECT_NAME}/INSTALLED
   )

   #############
   ## Install ##
   #############
   ## Mark executables and/or libraries for installation
#   install(TARGETS Qsopt
#   	ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   	LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   	RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
#   )

#   install(PROGRAMS common/lib/${MYARCH}/qsopt.a
#	   DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
 #  )


   install(DIRECTORY common/include/${PROJECT_NAME}/
	   DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
	   FILES_MATCHING PATTERN "*.h"
   )
else()
   # mark as not installed
   file(WRITE common/include/NOT_INSTALLED "")
endif()
