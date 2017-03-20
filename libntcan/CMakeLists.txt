cmake_minimum_required(VERSION 2.8.3)
project(libntcan)

find_package(catkin REQUIRED)

find_program(CMAKE_DPKG dpkg /bin /usr/bin /usr/local/bin) 
if(CMAKE_DPKG)
  exec_program(dpkg ARGS --print-architecture OUTPUT_VARIABLE CMAKE_DPKG_ARCH)
  if(CMAKE_DPKG_ARCH MATCHES "amd64")
    message(STATUS "++++++++++++++++++++++++++ DETECTED 64 bit +++++++++++++++++++++++++++++++++++")
    set(MYARCH "x86_64")
  else()
    message(STATUS "++++++++++++++++++++++++++ DETECTED 32 bit +++++++++++++++++++++++++++++++++++")
    set(MYARCH "i686")
  endif()
endif()

catkin_package(
    INCLUDE_DIRS common/include
    LIBRARIES ntcan
)

# copy headers and libs to devel space
file(COPY common/include/${PROJECT_NAME}/ntcan.h DESTINATION ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_INCLUDE_DESTINATION})
file(COPY common/lib/${MYARCH}/libntcan.so DESTINATION ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION})
file(COPY common/lib/${MYARCH}/libntcan.so.3 DESTINATION ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION})
file(COPY common/lib/${MYARCH}/libntcan.so.3.1.7 DESTINATION ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION})

install(PROGRAMS common/lib/${MYARCH}/libntcan.so common/lib/${MYARCH}/libntcan.so.3 common/lib/${MYARCH}/libntcan.so.3.1.7
    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

install(DIRECTORY common/include/${PROJECT_NAME}/
    DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)
