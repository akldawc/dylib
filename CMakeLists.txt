cmake_minimum_required(VERSION 3.10)
project(KeyVerifyDylib)

set(CMAKE_C_STANDARD 11)
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.15")
enable_language(OBJC)

# 生成macOS动态库
add_library(KeyVerifyDylib SHARED src/mylib.m)
target_link_libraries(KeyVerifyDylib "-framework Cocoa")

set_target_properties(KeyVerifyDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)