include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO OGRECave/ogre-next
    REF 7cb520fe467385b8ef5abc219e61f18d62ff4d74
    SHA512 cd3dc71a651784f1b8cd0dc873ebd47932e75d760f84032459d49a3fc34492d6d12b13bacfd24132398ff52f31ec6fd3fc9af2dab6d31b24af3f1a2b73d36ce9
    HEAD_REF master
    PATCHES 00001-fix-build.patch
)

vcpkg_from_github(
    OUT_SOURCE_PATH VCPKG_WX_FIND_SOURCE_PATH
    REPO CaeruleusAqua/vcpkg-wx-find
    REF 17993e942f677799b488a06ca659a8e46ff272c9
    SHA512 0fe07d3669f115c9b6a761abd7743f87e67f24d1eae3f3abee4715fa4d6b76af0d1ea3a4bd82dbdbed430ae50295e1722615ce0ee7d46182125f5048185ee153
    HEAD_REF master
)

file(COPY ${CMAKE_ROOT}/Modules/FindPackageHandleStandardArgs.cmake DESTINATION ${VCPKG_WX_FIND_SOURCE_PATH})
file(COPY ${CMAKE_ROOT}/Modules/FindPackageMessage.cmake DESTINATION ${VCPKG_WX_FIND_SOURCE_PATH})

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DCMAKE_MODULE_PATH=${VCPKG_WX_FIND_SOURCE_PATH}
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH share/cmake/wxogre)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

configure_file(${SOURCE_PATH}/COPYING ${CURRENT_PACKAGES_DIR}/share/wxogre/copyright COPYONLY)
