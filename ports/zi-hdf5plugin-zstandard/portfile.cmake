vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO zi-m/HDF5Plugin-Zstandard
    REF 005c48638bdb33735e5c90ceeea81c12f8fdc1fc
    SHA512 a53a7cdf45cbf922ffaea529a78507b1616d01ee6b3f3314f2c86d6db768aadfb610015eba3a49c810e6249fe7a1dafdef7688504c2c89ebd1daf86cd05f97f6
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
