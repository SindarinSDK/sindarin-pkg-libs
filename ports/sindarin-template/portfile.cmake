vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SindarinSDK/sindarin-template
    REF 794cfbcca2e42e0a5fe9b9fbaa186a36d014f7c4
    SHA512 10b2e87eb796350fe2144b41d819bf16823ab39b66716716da5b180717411c5aa8de7822c3f1b2235b959c440dfaec43be4939d892b5135328182ca2e6cae9e7
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_TESTING=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME sindarin-template CONFIG_PATH lib/cmake/sindarin-template)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "Copyright (c) SindarinSDK. All rights reserved.")
