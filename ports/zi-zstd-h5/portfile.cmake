vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO zi-m/HDF5Plugin-Zstandard
    REF fab9a1f995f1567221d41d548a2b0b7e2796df2c
    SHA512 7eb1837bb9c9959a583dcb65795773add3d7194dbb865715b1fd6028e6ab2b738e729906b3ed4500ba2a1bb092328000f9e139bbaf15e196fba1f529be4f55d8
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

file(INSTALL ${CURRENT_PACKAGES_DIR}/plugin/zstd_h5plugin.dll DESTINATION ${CURRENT_PACKAGES_DIR}/tools/${PORT})
vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/${PORT})

file(REMOVE_RECURSE 
	${CURRENT_PACKAGES_DIR}/plugin 
	${CURRENT_PACKAGES_DIR}/debug/plugin
	${CURRENT_PACKAGES_DIR}/debug/include 
	${CURRENT_PACKAGES_DIR}/debug/share
)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
