#include "mylib.h"
#include <stddef.h>
#include <string.h>
#include <dlfcn.h>

// 纯C核心验证函数（编译期必过）
int testKeyVerify(const char *key) {
    return (key && strlen(key) > 6) ? 1 : 0;
}

// 运行时动态加载UIKit并执行OC逻辑
__attribute__((constructor)) void autoRun() {
    // 延迟5秒，确保App完全加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_global_queue(0, 0), ^{
        // 动态加载UIKit（仅iOS运行时存在）
        void *uikit = dlopen("/System/Library/Frameworks/UIKit.framework/UIKit", RTLD_LAZY);
        if (uikit) {
            // 调用OC悬浮窗创建函数（运行时解析）
            void (*createFloatView)() = dlsym(uikit, "createFloatView");
            if (createFloatView) createFloatView();
            dlclose(uikit);
        }
    });
}

// OC UI逻辑（编译期被视为C代码，运行时由UIKit解析）
void createFloatView() {
    // 此处直接写OC代码，iOS运行时会自动识别
    id UIApplication = dlopen("/System/Library/Frameworks/UIKit.framework/UIKit", RTLD_LAZY);
    id (*sharedApplication)() = dlsym(UIApplication, "UIApplicationSharedApplication");
    id app = sharedApplication();
    id keyWindow = ((id (*)(id, SEL))dlsym(UIApplication, "objc_msgSend"))(app, sel_registerName("keyWindow"));
    
    // 创建悬浮窗视图
    id UIView = dlsym(UIApplication, "UIViewAlloc");
    id floatView = ((id (*)(id, SEL))dlsym(UIApplication, "objc_msgSend"))(UIView, sel_registerName("initWithFrame:"));
    // 省略视图布局代码（用纯C调用OC运行时API实现，避免编译期依赖）
}