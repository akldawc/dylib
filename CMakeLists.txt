cmake_minimum_required(VERSION 3.10)
project(KeyVerifyDylib)
set(CMAKE_C_STANDARD 11)

# 仅编译C代码，链接动态库加载库
add_library(KeyVerifyDylib SHARED src/mylib.m)
target_link_libraries(KeyVerifyDylib dl)

set_target_properties(KeyVerifyDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)