#import <UIKit/UIKit.h>
#import "mylib.h"

static UIView *floatVerifyView = nil;
static UITextField *keyTextField = nil;

void createFloatVerifyView() {
    // 粘贴之前的悬浮窗创建代码（完整UI逻辑）
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat floatW = 300, floatH = 180;
    CGFloat floatX = (screenBounds.size.width - floatW)/2;
    CGFloat floatY = screenBounds.size.height * 0.3;

    floatVerifyView = [[UIView alloc] initWithFrame:CGRectMake(floatX, floatY, floatW, floatH)];
    floatVerifyView.backgroundColor = [UIColor whiteColor];
    floatVerifyView.layer.cornerRadius = 12;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,15,floatW,25)];
    titleLabel.text = @"卡密验证";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [floatVerifyView addSubview:titleLabel];

    keyTextField = [[UITextField alloc] initWithFrame:CGRectMake(20,55,floatW-40,35)];
    keyTextField.placeholder = @"请输入6位以上卡密";
    keyTextField.borderStyle = UITextBorderStyleRoundedRect;
    [floatVerifyView addSubview:keyTextField];

    UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    verifyBtn.frame = CGRectMake(40,110,floatW-80,40);
    [verifyBtn setTitle:@"验证卡密" forState:UIControlStateNormal];
    [verifyBtn setBackgroundColor:[UIColor systemBlueColor]];
    [verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verifyBtn addTarget:self action:@selector(verifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [floatVerifyView addSubview:verifyBtn];

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:floatVerifyView];

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFloatView:)];
    [floatVerifyView addGestureRecognizer:pan];
}

void verifyButtonClick(UIButton *btn) {
    char *key = (char *)[keyTextField.text UTF8String];
    int result = testKeyVerify(key);
    showAlert(result ? @"验证成功" : @"验证失败", result ? @"卡密有效" : @"卡密无效");
}

void showAlert(NSString *title, NSString *msg) {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (rootVC.presentedViewController) rootVC = rootVC.presentedViewController;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [rootVC presentViewController:alert animated:YES completion:nil];
}

void panFloatView(UIPanGestureRecognizer *pan) {
    CGPoint translation = [pan translationInView:floatVerifyView.superview];
    floatVerifyView.center = CGPointMake(floatVerifyView.center.x + translation.x, floatVerifyView.center.y + translation.y);
    [pan setTranslation:CGPointZero inView:floatVerifyView.superview];
}