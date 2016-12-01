This package wraps the external library Qsopt, which is provided as a static library (common/include/libqsopt/qsopt.a). To use it, link the library with an absolut path in the executable you want to use Qsopt. For example you can add the following to your CMakeLists.txt:

find_package(libqsopt REQUIRED)

and when setting your executable

target_link_libraries(my_executable
	${libqsopt_INCLUDE_DIRS}/libqsopt/qsopt.a
)
