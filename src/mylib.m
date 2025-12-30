#import "mylib.h"
#import <UIKit/UIKit.h>

// 悬浮窗容器
static UIView *verifyFloatView = nil;
// 输入框
static UITextField *keyInputTF = nil;

// 模拟验证按钮点击
void verifyKeyAction(UIButton *btn) {
    NSString *inputKey = keyInputTF.text?:@"";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"验证结果"
                                                                   message:inputKey.length>0?
                                                                   [NSString stringWithFormat:@"卡密「%@」模拟验证成功！",inputKey]:
                                                                   @"请输入卡密后验证！"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 获取当前顶层控制器
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    [topVC presentViewController:alert animated:YES completion:nil];
}

// 创建悬浮窗
void showKeyVerifyWindow(UIViewController *vc) {
    // 避免重复创建
    if (verifyFloatView) {
        [verifyFloatView removeFromSuperview];
        verifyFloatView = nil;
    }
    
    // 悬浮窗主视图
    verifyFloatView = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 300, 150)];
    verifyFloatView.backgroundColor = [UIColor whiteColor];
    verifyFloatView.layer.cornerRadius = 10;
    verifyFloatView.layer.shadowColor = [UIColor blackColor].CGColor;
    verifyFloatView.layer.shadowOpacity = 0.3;
    verifyFloatView.layer.shadowOffset = CGSizeMake(2, 2);
    
    // 标题标签
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 300, 20)];
    titleLab.text = @"卡密验证";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont boldSystemFontOfSize:16];
    [verifyFloatView addSubview:titleLab];
    
    // 输入框
    keyInputTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 50, 260, 30)];
    keyInputTF.placeholder = @"请输入卡密";
    keyInputTF.borderStyle = UITextBorderStyleRoundedRect;
    keyInputTF.font = [UIFont systemFontOfSize:14];
    [verifyFloatView addSubview:keyInputTF];
    
    // 验证按钮
    UIButton *verifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    verifyBtn.frame = CGRectMake(80, 95, 140, 30);
    [verifyBtn setTitle:@"模拟验证卡密" forState:UIControlStateNormal];
    [verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [verifyBtn setBackgroundColor:[UIColor systemBlueColor]];
    verifyBtn.layer.cornerRadius = 5;
    [verifyBtn addTarget:self action:@selector(verifyKeyAction:) forControlEvents:UIControlEventTouchUpInside];
    [verifyFloatView addSubview:verifyBtn];
    
    // 添加到控制器视图
    [vc.view addSubview:verifyFloatView];
    // 开启拖拽（可选）
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFloatView:)];
    [verifyFloatView addGestureRecognizer:pan];
}

// 悬浮窗拖拽逻辑
void panFloatView(UIPanGestureRecognizer *pan) {
    CGPoint trans = [pan translationInView:verifyFloatView.superview];
    verifyFloatView.center = CGPointMake(verifyFloatView.center.x + trans.x, verifyFloatView.center.y + trans.y);
    [pan setTranslation:CGPointZero inView:verifyFloatView.superview];
}