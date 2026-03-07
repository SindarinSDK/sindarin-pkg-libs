vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SindarinSDK/sindarin-template
    REF 8750a2343e90a1988e0fc76607dd5a0713dfa5f9
    SHA512 d66f4c8dd9e6f9b4be4cedf2991480a239b44ded925345abdc4f89e3473564f12bf97af1c707c3a07172a7dd5bf1db16dcd4bad711e82fc409cf033bef0c7016
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
