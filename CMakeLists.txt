cmake_minimum_required(VERSION 3.10)
project(KeyVerifyDylib)
set(CMAKE_C_STANDARD 11)

# 仅编译C代码，忽略OC部分
add_definitions(-U__OBJC__)
add_library(KeyVerifyDylib SHARED src/mylib.m)

set_target_properties(KeyVerifyDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)