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

include_directories(common/include)

message(STATUS "Copying ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so to ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}/libntcan.so")

add_custom_target(
    build_ntcan ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
)
add_custom_target(
    build_ntcan3 ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so.3 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
)
add_custom_target(
    build_ntcan317 ALL
    COMMAND ${CMAKE_COMMAND} -E copy ${PROJECT_SOURCE_DIR}/common/lib/${MYARCH}/libntcan.so.3.1.7 ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_LIB_DESTINATION}
)

add_library(ntcan SHARED)
set_target_properties(ntcan PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(ntcan build_ntcan)
add_dependencies(ntcan build_ntcan3)
add_dependencies(ntcan build_ntcan317)

install(TARGETS ntcan
    ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
    LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
    RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
)

install(PROGRAMS common/lib/${MYARCH}/libntcan.so common/lib/${MYARCH}/libntcan.so.3 common/lib/${MYARCH}/libntcan.so.3.1.7
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

install(DIRECTORY common/include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
)
