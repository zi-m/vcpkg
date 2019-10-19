cmake_minimum_required(VERSION 3.13)
project(wxogre CXX)

set(wxWidgets_EXCLUDE_COMMON_LIBRARIES TRUE)
find_package(wxWidgets REQUIRED COMPONENTS core base)
include(${wxWidgets_USE_FILE})

find_package(OGRE CONFIG REQUIRED)

add_library(wxogre STATIC Tools/MaterialEditor/MaterialEditor/src/wxOgre.cpp)

target_include_directories(wxogre PUBLIC 
	$<INSTALL_INTERFACE:include>
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Tools/MaterialEditor/MaterialEditor/include>
)

target_link_libraries(wxogre 
	PRIVATE OgreMain OgreBites
	PRIVATE ${wxWidgets_LIBRARIES}
)

install(TARGETS wxogre EXPORT wxogre-config 
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

install(EXPORT wxogre-config DESTINATION share/cmake/wxogre)
install(FILES Tools/MaterialEditor/MaterialEditor/include/wxOgre.h DESTINATION include)
