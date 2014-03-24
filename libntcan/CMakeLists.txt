# http://ros.org/doc/groovy/api/catkin/html/user_guide/supposed.html
cmake_minimum_required(VERSION 2.8.3)
project(libntcan)

find_package(catkin REQUIRED)

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




install(FILES common/lib/${MYARCH}/libntcan.so common/lib/${MYARCH}/libntcan.so.3 common/lib/${MYARCH}/libntcan.so.3.1.7
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  )

install(DIRECTORY common/include/
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)

install(DIRECTORY common/include/libntcan
  DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
)

