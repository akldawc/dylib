cmake_minimum_required(VERSION 3.10)
project(KeyVerifyDylib)
set(CMAKE_C_STANDARD 11)

# 指定为iOS平台，arm64架构
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_OSX_ARCHITECTURES arm64)
set(CMAKE_OSX_SYSROOT iphoneos)

# 仅编译纯C代码
add_library(KeyVerifyDylib SHARED src/mylib.m)

# 指定输出路径
set_target_properties(KeyVerifyDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
    # 生成dylib的名称匹配iOS端的libTestDylib.dylib
    OUTPUT_NAME "TestDylib"
)