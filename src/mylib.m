#include "mylib.h"
#include <stddef.h>
// 替换<string.h>为手动实现字符串长度函数，避免头文件依赖
int my_strlen(const char *key) {
    int len = 0;
    while (key && key[len]) len++;
    return len;
}

// 卡密验证函数（用自定义my_strlen替代strlen）
int testKeyVerify(const char *key) {
    int len = my_strlen(key);
    return (len > 6) ? 1 : 0;
}