# http://ros.org/doc/groovy/api/catkin/html/user_guide/supposed.html
cmake_minimum_required(VERSION 2.8.3)
project(libntcan)


if(“${CMAKE_SYSTEM_PROCESSOR}” STREQUAL “x86_64”)
  message(STATUS "++++++++++++++++++++++++++ DETECTED 64 bit +++++++++++++++++++++++++++++++++++")
  set(MYARCH "x86_64")
else(“${CMAKE_SYSTEM_PROCESSOR}” STREQUAL “x86_64”)
  message(STATUS "++++++++++++++++++++++++++ DETECTED 32 bit +++++++++++++++++++++++++++++++++++")
  set(MYARCH "i686")
endif(“${CMAKE_SYSTEM_PROCESSOR}” STREQUAL “x86_64”)

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

add_library(ntcan SHARED)
set_target_properties(ntcan PROPERTIES LINKER_LANGUAGE CXX)

add_dependencies(ntcan build_ntcan)
add_dependencies(ntcan build_ntcan3)
add_dependencies(ntcan build_ntcan317)

#add_dependencies(ntcan copy_ntcan)
#add_custom_target(ntcan DEPENDS ${CATKIN_DEVEL_PREFIX}/${CATKIN_GLOBAL_LIB_DESTINATION}/libntcan.so)

# TODO: fill in what other packages will need to use this package
## DEPENDS: system dependencies of this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## INCLUDE_DIRS: 
## LIBRARIES: libraries you create in this project that dependent projects also need
catkin_package(
    DEPENDS  # TODO
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS common/include common/include/libntcan
    LIBRARIES ntcan
)
