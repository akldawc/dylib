cmake_minimum_required(VERSION 3.10)
project(KeyVerifyDylib)
set(CMAKE_C_STANDARD 11)

# 指定macOS arm64架构（与iOS设备架构一致）
set(CMAKE_OSX_ARCHITECTURES arm64)
set(CMAKE_OSX_SYSROOT macosx)

# 编译纯C代码，输出名为TestDylib
add_library(KeyVerifyDylib SHARED src/mylib.m)
set_target_properties(KeyVerifyDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
    OUTPUT_NAME "TestDylib"
)