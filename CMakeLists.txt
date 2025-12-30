cmake_minimum_required(VERSION 3.10)
project(iOSKeyVerifyDylib)

# 设置为iOS平台编译
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_OSX_SYSROOT iphoneos)
set(CMAKE_OSX_ARCHITECTURES arm64) # 仅编译ARM64（iOS设备架构）
set(CMAKE_IOS_DEPLOYMENT_TARGET 14.0) # 最低支持iOS14

# 识别Objective-C文件
enable_language(OBJC)

# 生成动态库
add_library(iOSKeyVerifyDylib SHARED src/mylib.m)

# 链接UIKit框架（iOS UI核心）
target_link_libraries(iOSKeyVerifyDylib "-framework UIKit" "-framework Foundation")

# 关闭bitcode（全能签兼容）
set_target_properties(iOSKeyVerifyDylib PROPERTIES
    XCODE_ATTRIBUTE_ENABLE_BITCODE "NO"
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)