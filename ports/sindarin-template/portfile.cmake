vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SindarinSDK/sindarin-template
    REF 26b64dcca000c2596d2c014119d09489ab4ca14d
    SHA512 be7d99a73a90369fe70c8ad40c27bf2fb4b78b8fff125bebbe5de284e6f02fa7fbb80231271df7293f38e4c68c8b69d8a02e09a0f38e1f9109b97db365a4a5eb
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
