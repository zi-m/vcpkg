cmake_minimum_required(VERSION 3.13)
project(wxchartdir CXX)

find_package(wxwidgets CONFIG REQUIRED)
find_package(chartdir CONFIG REQUIRED)

add_library(wxchartdir STATIC wxdemo/common/wxchartviewer.cpp)

target_include_directories(wxchartdir PUBLIC
    $<INSTALL_INTERFACE:include>
)

target_link_libraries(wxchartdir 
    PRIVATE wxbase wxcore
    PRIVATE chartdir
)

install(TARGETS wxchartdir EXPORT wxchartdir-config 
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

install(EXPORT wxchartdir-config DESTINATION share/cmake/wxchartdir)

install(FILES wxdemo/common/mondrian.xpm DESTINATION include/wxchartdir)
install(FILES wxdemo/common/wxchartviewer.h DESTINATION include/wxchartdir)
install(FILES wxdemo/common/wxchartviewer_defs.h DESTINATION include/wxchartdir)
install(FILES wxdemo/common/wxchartviewer_version.h DESTINATION include/wxchartdir)
install(FILES wxdemo/common/wxchartviewer_version.rc DESTINATION include/wxchartdir)
