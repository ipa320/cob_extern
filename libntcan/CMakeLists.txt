# http://ros.org/doc/groovy/api/catkin/html/user_guide/supposed.html
cmake_minimum_required(VERSION 2.8.3)
project(libntcan)

find_package(catkin REQUIRED)

FIND_PROGRAM(CMAKE_DPKG dpkg /bin /usr/bin /usr/local/bin )
IF(CMAKE_DPKG)
  EXEC_PROGRAM(dpkg ARGS --print-architecture OUTPUT_VARIABLE CMAKE_DPKG_ARCH)
  IF(CMAKE_DPKG_ARCH MATCHES "amd64")
    message(STATUS "++++++++++++++++++++++++++ DETECTED 64 bit +++++++++++++++++++++++++++++++++++")
    set(MYARCH "x86_64")
  ELSE(CMAKE_DPKG_ARCH MATCHES "amd64")
    message(STATUS "++++++++++++++++++++++++++ DETECTED 32 bit +++++++++++++++++++++++++++++++++++")
    set(MYARCH "i686")
  ENDIF(CMAKE_DPKG_ARCH MATCHES "amd64")
ENDIF(CMAKE_DPKG)


message(STATUS "Copying ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so to ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/libntcan.so")

add_custom_target(
    build_ntcan ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}
    )
add_custom_target(
    build_ntcan3 ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so.3 ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}
    )
add_custom_target(
    build_ntcan317 ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so.3.1.7 ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}
    )

catkin_package(
    DEPENDS  # TODO
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS common/include common/include/libntcan
    LIBRARIES ntcan
)

add_library(ntcan SHARED)
set_target_properties(ntcan PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(ntcan build_ntcan)
add_dependencies(ntcan build_ntcan3)
add_dependencies(ntcan build_ntcan317)




install(PROGRAMS common/lib/${MYARCH}/libntcan.so common/lib/${MYARCH}/libntcan.so.3 common/lib/${MYARCH}/libntcan.so.3.1.7
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  )

install(FILES common/include/libntcan/ntcan.h 
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)  


install(DIRECTORY common/include/
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)

install(DIRECTORY common/include/libntcan
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)

