
vcpkg_download_distfile(ARCHIVE
    URLS "https://netix.dl.sourceforge.net/project/wxmathplot/wxmathplot/0.1.2/wxMathPlot-0.1.2.tar.gz"
    FILENAME "wxMathPlot-0.1.2.tar.gz"
    SHA512 528354345544f2553e09cd0d6f4c6e69aa1e2e938a7ae2615c5546e1a2718fbdc1b9f325e4e11368825ae54b185bc5f8aec6a1a9796abce57fec052f14ee1607
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
    PATCHES 0001-wxmathplot-svn-r95-trunk.patch
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DCMAKE_MODULE_PATH=${VCPKG_WX_FIND_SOURCE_PATH}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH share/cmake/wxmathplot)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

configure_file(${SOURCE_PATH}/debian/copyright ${CURRENT_PACKAGES_DIR}/share/wxmathplot/copyright COPYONLY)
