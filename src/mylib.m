#import "mylib.h"
#import <stddef.h>
#import <UIKit/UIKit.h>

static UIView *floatVerifyView = nil; // 悬浮窗视图
static UITextField *keyTextField = nil; // 卡密输入框

// 卡密验证核心函数
int testKeyVerify(char *key) {
    if (key == NULL || key[0] == '\0') return 0;
    int len = 0;
    while (key[len] != '\0') len++;
    return len > 6 ? 1 : 0;
}

// 验证按钮点击事件
void verifyButtonClick(UIButton *btn) {
    char *key = (char *)[keyTextField.text UTF8String];
    int result = testKeyVerify(key);
    
    // 显示验证结果弹窗
    NSString *title = result ? @"验证成功" : @"验证失败";
    NSString *msg = result ? @"卡密有效，已解锁功能！" : @"卡密无效或为空，请重新输入";
    showAlert(title, msg);
}

// 弹窗提示函数
void showAlert(NSString *title, NSString *msg) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        // 多层控制器时，获取最顶层的可见控制器
        while (rootVC.presentedViewController) {
            rootVC = rootVC.presentedViewController;
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

// 创建悬浮窗
void createFloatVerifyView() {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 获取屏幕尺寸
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        CGFloat floatW = 300;
        CGFloat floatH = 180;
        CGFloat floatX = (screenBounds.size.width - floatW) / 2;
        CGFloat floatY = screenBounds.size.height * 0.3;
        
        // 创建悬浮窗主视图
        floatVerifyView = [[UIView alloc] initWithFrame:CGRectMake(floatX, floatY, floatW, floatH)];
        floatVerifyView.backgroundColor = [UIColor whiteColor];
        floatVerifyView.layer.cornerRadius = 12;
        floatVerifyView.layer.shadowColor = [UIColor blackColor].CGColor;
        floatVerifyView.layer.shadowOpacity = 0.3;
        floatVerifyView.layer.shadowOffset = CGSizeMake(0, 2);
        floatVerifyView.layer.shadowRadius = 8;
        
        // 添加标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, floatW, 25)];
        titleLabel.text = @"卡密验证";
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [floatVerifyView addSubview:titleLabel];
        
        // 添加输入框
        keyTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 55, floatW - 40, 35)];
        keyTextField.placeholder = @"请输入6位以上卡密";
        keyTextField.borderStyle = UITextBorderStyleRoundedRect;
        keyTextField.font = [UIFont systemFontOfSize:15];
        [floatVerifyView addSubview:keyTextField];
        
        // 添加验证按钮
        UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        verifyBtn.frame = CGRectMake(40, 110, floatW - 80, 40);
        [verifyBtn setTitle:@"验证卡密" forState:UIControlStateNormal];
        [verifyBtn setBackgroundColor:[UIColor systemBlueColor]];
        [verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        verifyBtn.layer.cornerRadius = 8;
        [verifyBtn addTarget:self action:@selector(verifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [floatVerifyView addSubview:verifyBtn];
        
        // 将悬浮窗添加到最顶层窗口
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:floatVerifyView];
        // 让悬浮窗可拖动（可选）
        floatVerifyView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFloatView:)];
        [floatVerifyView addGestureRecognizer:pan];
    });
}

// 悬浮窗拖动事件
void panFloatView(UIPanGestureRecognizer *pan) {
    CGPoint translation = [pan translationInView:floatVerifyView.superview];
    floatVerifyView.center = CGPointMake(floatVerifyView.center.x + translation.x, floatVerifyView.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:floatVerifyView.superview];
}

// App启动时自动创建悬浮窗
__attribute__((constructor)) void autoRun() {
    // 延迟1秒创建，确保App界面加载完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        createFloatVerifyView();
    });
}