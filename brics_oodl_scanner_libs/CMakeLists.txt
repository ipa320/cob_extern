cmake_minimum_required(VERSION 2.4.6)
include($ENV{ROS_ROOT}/core/rosbuild/rosbuild.cmake)

# Set the build type.  Options are:
#  Coverage       : w/ debug symbols, w/o optimization, w/ code-coverage
#  Debug          : w/ debug symbols, w/o optimization
#  Release        : w/o debug symbols, w/ optimization
#  RelWithDebInfo : w/ debug symbols, w/ optimization
#  MinSizeRel     : w/o debug symbols, w/ optimization, stripped binaries
#set(ROS_BUILD_TYPE RelWithDebInfo)

rosbuild_init()

include_directories(
    oodl
)

SET(OODL_SickS300_SRC
  oodl/generic/Errors.cpp
  oodl/generic/Logger.cpp
  oodl/generic-laser-scanner/LaserScanner.cpp
  oodl/generic-laser-scanner/LaserScannerData.cpp
  oodl/generic-laser-scanner/LaserScannerConfiguration.cpp
  oodl/generic-laser-scanner/LaserScannerDataWithIntensities.cpp
  oodl/sick-s300/SickS300.cpp
  oodl/sick-s300/ScannerSickS300.cpp
  oodl/sick-s300/SerialIO.cpp
)

set(OODL_HOKUYO_URG_SRC
  oodl/generic/Errors.cpp
  oodl/generic/Logger.cpp
  oodl/generic-laser-scanner/LaserScanner.cpp
  oodl/generic-laser-scanner/LaserScannerData.cpp
  oodl/generic-laser-scanner/LaserScannerConfiguration.cpp
  oodl/generic-laser-scanner/LaserScannerDataWithIntensities.cpp
  oodl/hokuyo-urg/HokuyoURG.cpp
  oodl/hokuyo-urg/HokuyoURGConfiguration.cpp
)

#set the default path for built executables to the "bin" directory
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
#set the default path for built libraries to the "lib" directory
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)

#uncomment if you have defined messages
#rosbuild_genmsg()
#uncomment if you have defined services
#rosbuild_gensrv()
rosbuild_add_boost_directories()


#common commands for building c++ executables and libraries
# SickS300
rosbuild_add_library(${PROJECT_NAME}_s300 ${OODL_SickS300_SRC})
rosbuild_add_executable(${PROJECT_NAME}_sick_test oodl/sick-s300/applications/Test.cpp)
rosbuild_link_boost(${PROJECT_NAME}_sick_test thread)
target_link_libraries(${PROJECT_NAME}_sick_test ${PROJECT_NAME}_s300)

# HokuyoURG
rosbuild_add_library(${PROJECT_NAME}_hokuyo ${OODL_HOKUYO_URG_SRC})
rosbuild_add_executable(${PROJECT_NAME}_hokuyo_test oodl/hokuyo-urg/applications/Test.cpp ${OODL_HOKUYO_URG_SRC})
rosbuild_link_boost(${PROJECT_NAME}_hokuyo_test thread)
