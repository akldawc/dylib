#include "mylib.h"
#include <stddef.h>
#include <string.h>

// 纯C语言卡密验证核心函数（编译期无任何iOS依赖）
int testKeyVerify(const char *key) {
    if (key == NULL || strlen(key) == 0) {
        return 0; // 空卡密，验证失败
    }
    return strlen(key) > 6 ? 1 : 0; // 长度>6则验证成功
}

// 空函数占位（仅在iOS运行时被动态替换，编译期不校验）
void autoRun() {}