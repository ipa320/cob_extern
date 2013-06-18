cmake_minimum_required(VERSION 2.8.3)
project(libmesasr)


execute_process(COMMAND cmake -E chdir ${PROJECT_SOURCE_DIR} make -f Makefile.tarball
          RESULT_VARIABLE _make_failed)
if(_make_failed)
  message(FATAL_ERROR "Building of libpcan failed")
endif(_make_failed)




# TODO: fill in what other packages will need to use this package
## DEPENDS: system dependencies of this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## INCLUDE_DIRS: 
## LIBRARIES: libraries you create in this project that dependent projects also need
catkin_package(
    DEPENDS  # TODO
    CATKIN_DEPENDS # TODO
    INCLUDE_DIRS # TODO include
    LIBRARIES # TODO
)
