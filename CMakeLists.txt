cmake_minimum_required(VERSION 3.10)
project(KeyVerifyDylib)
set(CMAKE_C_STANDARD 11)
enable_language(OBJC)

# 仅编译核心验证逻辑，无UI框架依赖
add_library(KeyVerifyDylib SHARED src/mylib.m)

set_target_properties(KeyVerifyDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)