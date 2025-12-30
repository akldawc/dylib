cmake_minimum_required(VERSION 3.10)
project(KeyVerifyDylib)
set(CMAKE_C_STANDARD 11)

# 仅编译纯C代码，无OBJC依赖
add_library(KeyVerifyDylib SHARED src/mylib.m)

set_target_properties(KeyVerifyDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)