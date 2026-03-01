vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO SindarinSDK/sindarin-template
    REF a0d8ecf6f9df494fd1ee1922f8653466420c7fd1
    SHA512 4d6f4887d9a5faac75157abcebf557a606f63ed68de9b59651e288180ac95e8377cfd36303efaecda71bdba60a6d3591bc3c0dc87f0f61dc918133eb187490fb
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
