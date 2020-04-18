vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO zi-m/HDF5Plugin-Zstandard
    REF c7540430aa5000b8738722a74ae316b1ad35dd09
    SHA512 5c73f440f531cba8dfe577889b05cc6e3fb971dd698fdf05443f5e28d207ca62947182fac63cd3f46511f975d7dcf2dcff01a5de8f2112751ea02c88924cceb7
    HEAD_REF master
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(zstd_h5_SHARED 0)
else()
    set(zstd_h5_SHARED 1)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -Dzstd_h5_SHARED=${zstd_h5_SHARED}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH share/cmake/${PORT})

file(INSTALL ${CURRENT_PACKAGES_DIR}/plugin/zstd_h5plugin${VCPKG_TARGET_SHARED_LIBRARY_SUFFIX} DESTINATION ${CURRENT_PACKAGES_DIR}/tools/${PORT})
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

file(REMOVE_RECURSE 
	${CURRENT_PACKAGES_DIR}/plugin 
	${CURRENT_PACKAGES_DIR}/debug/plugin
	${CURRENT_PACKAGES_DIR}/debug/include 
	${CURRENT_PACKAGES_DIR}/debug/share
)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
