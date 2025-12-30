#include "mylib.h"
#include <stddef.h>
#include <string.h>

// 纯C卡密验证核心（编译期正常执行）
int testKeyVerify(const char *key) {
    return (key && strlen(key) > 6) ? 1 : 0;
}

// 编译期屏蔽OC代码（GitHub环境无UIKit，不会编译这段）
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) || defined(__OBJC__)
#import <UIKit/UIKit.h>

static UIView *floatView;
static UITextField *keyTF;

// OC弹窗函数
void showAlert(NSString *title, NSString *msg) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (vc.presentedViewController) vc = vc.presentedViewController;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [vc presentViewController:alert animated:YES completion:nil];
    });
}

// OC悬浮窗创建函数
void createFloatView() {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect bounds = [[UIScreen mainScreen] bounds];
        floatView = [[UIView alloc] initWithFrame:CGRectMake((bounds.size.width-300)/2, bounds.size.height*0.3, 300, 180)];
        floatView.backgroundColor = [UIColor whiteColor];
        floatView.layer.cornerRadius = 12;

        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0,15,300,25)];
        title.text = @"卡密验证";
        title.font = [UIFont boldSystemFontOfSize:18];
        title.textAlignment = NSTextAlignmentCenter;
        [floatView addSubview:title];

        keyTF = [[UITextField alloc] initWithFrame:CGRectMake(20,55,260,35)];
        keyTF.placeholder = @"输入6位以上卡密";
        keyTF.borderStyle = UITextBorderStyleRoundedRect;
        [floatView addSubview:keyTF];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(40,110,220,40);
        [btn setTitle:@"验证" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor systemBlueColor]];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(verify:) forControlEvents:UIControlEventTouchUpInside];
        [floatView addSubview:btn];

        [[UIApplication sharedApplication].keyWindow addSubview:floatView];
    });
}

// 验证按钮点击事件
void verify:(UIButton *)btn {
    const char *key = [keyTF.text UTF8String];
    int res = testKeyVerify(key);
    showAlert(res ? @"成功" : @"失败", res ? @"卡密有效" : @"卡密无效/过短");
}

// App启动时延迟执行
__attribute__((constructor)) void autoRun() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        createFloatView();
    });
}
#endif