This package wraps the external c++ library dlib (http://dlib.net/) to use it in other ROS packages. See the Makefile.tarball on how to build it with the console.

HOW TO USE THIS PACKAGE:

Most of Dlib is a header-only library, so if you want to use one of these functions just include the header and that's it. Some functions however have an additional source-code that is build as a static library (common/include/libdlib/build/libdlib.a). To use these, link the library with an absolut path in the executable you want to use Dlib. For example you can add the following to your CMakeLists.txt:

find_package(libdlib REQUIRED)

and when setting your executable

target_link_libraries(my_executable
	${libdlib_INCLUDE_DIRS}/libdlib/build/libdlib.a
)
