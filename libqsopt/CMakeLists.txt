cmake_minimum_required(VERSION 2.8.3)
project(libqsopt)

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


if(SUPPORTED MATCHES "true")
  catkin_package(
    CFG_EXTRAS libqsopt-extras.cmake # catkin_package does not support artifacts in devel space
  )

  install(FILES common/lib/${MYARCH}/qsopt.a
    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  )

  install(FILES common/lib/${MYARCH}/qsopt.h
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  )
endif()
