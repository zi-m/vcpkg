vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO zi-m/HDF5Plugin-Zstandard
    REF 0d64689ef1c06d4f3554ce484552066f6179e1e3
    SHA512 bbbc91162b742c723c89e9c799d0b67f30fc2a6b3b70c2768bb90d8b8da4de054fd638b76073b2a92010e76286730f92540acae61f9eff4a31d4502129c4bd0a
    HEAD_REF master
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    set(zstd_hdf5_SHARED 0)
else()
    set(zstd_hdf5_SHARED 1)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -Dzstd_hdf5_PLUGIN=0
        -Dzstd_hdf5_SHARED=${zstd_hdf5_SHARED}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH share/cmake/zi-hdf5plugin-zstandard)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/zi-hdf5plugin-zstandard/copyright COPYONLY)
