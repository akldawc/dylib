cmake_minimum_required(VERSION 3.10)
project(MyTestDylib)
# 生成动态库
add_library(MyTestDylib SHARED src/mylib.c)
# 设置输出路径
set_target_properties(MyTestDylib PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib
)