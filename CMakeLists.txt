cmake_minimum_required(VERSION 3.10)
project(TestDylib)
set(CMAKE_C_STANDARD 11)
enable_language(OBJC) # 启用Objective-C编译
add_library(TestDylib SHARED src/mylib.m)
set_target_properties(TestDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)