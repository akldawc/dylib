#import "mylib.h"

// 模拟卡密验证：非空且长度>6即成功
int testKeyVerify(char *key) {
    if (key == NULL || key[0] == '\0') {
        return 0;
    }
    int len = 0;
    while (key[len] != '\0') len++;
    return len > 6 ? 1 : 0;
}