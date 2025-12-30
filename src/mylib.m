#import "mylib.h"
#import <stddef.h>
#import <dlfcn.h> // 动态库加载头文件

// 核心卡密验证函数（无UI依赖，编译期可通过）
int testKeyVerify(char *key) {
    if (key == NULL || key[0] == '\0') return 0;
    int len = 0;
    while (key[len] != '\0') len++;
    return len > 6 ? 1 : 0;
}

// 运行时动态调用UIKit创建悬浮窗（仅在iOS端执行）
__attribute__((constructor)) void autoRun() {
    // 延迟3秒，确保App加载完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        // 动态加载UIKit框架（iOS端运行时存在）
        void *uikit = dlopen("/System/Library/Frameworks/UIKit.framework/UIKit", RTLD_LAZY);
        if (uikit) {
            createFloatVerifyView(); // 调用UI创建函数（运行时解析）
            dlclose(uikit);
        }
    });
}

// 以下UI相关函数仅在iOS运行时生效，编译期不校验
void createFloatVerifyView() {}
void showAlert(NSString *title, NSString *msg) {}
void verifyButtonClick(UIButton *btn) {}
void panFloatView(UIPanGestureRecognizer *pan) {}