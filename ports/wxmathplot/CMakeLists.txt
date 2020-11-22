cmake_minimum_required(VERSION 3.13)
project(wxmathplot CXX)

option(BUILD_SHARED_LIBS "Build shared instead of static library" ON)

find_package(wxwidgets CONFIG REQUIRED)

if(BUILD_SHARED_LIBS)
	add_library(wxmathplot SHARED mathplot.cpp mathplot.h)
	target_compile_definitions(wxmathplot PRIVATE -Dmathplot_EXPORTS)
else()
	add_library(wxmathplot STATIC mathplot.cpp mathplot.h)
endif()

target_include_directories(wxmathplot PUBLIC 
	$<INSTALL_INTERFACE:include>
)

target_link_libraries(wxmathplot PRIVATE 
	wxbase wxcore
)

install(TARGETS wxmathplot EXPORT wxmathplot-config 
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

install(EXPORT wxmathplot-config DESTINATION share/cmake/wxmathplot)
install(FILES mathplot.h DESTINATION include/wxmathplot)
