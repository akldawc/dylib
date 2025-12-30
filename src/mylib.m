#import "mylib.h"
#import <Cocoa/Cocoa.h>

static NSWindow *verifyWin = nil;

void showKeyVerifyWindow() {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];

    // 创建悬浮窗
    verifyWin = [[NSWindow alloc] initWithContentRect:NSMakeRect(200, 200, 300, 150)
                                           styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable
                                             backing:NSBackingStoreBuffered
                                               defer:NO];
    [verifyWin setTitle:@"卡密验证"];
    [verifyWin setLevel:NSFloatingWindowLevel];
    [verifyWin center];

    // 内容视图
    NSView *content = [verifyWin contentView];

    // 标题
    NSTextField *title = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 110, 300, 20)];
    title.stringValue = @"卡密验证";
    title.editable = NO;
    title.bordered = NO;
    title.alignment = NSTextAlignmentCenter;
    [content addSubview:title];

    // 输入框
    NSTextField *tf = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 70, 260, 24)];
    tf.placeholderString = @"请输入卡密";
    [content addSubview:tf];

    // 验证按钮
    NSButton *btn = [[NSButton alloc] initWithFrame:NSMakeRect(100, 30, 100, 30)];
    btn.title = @"模拟验证";
    btn.bezelStyle = NSBezelStyleRounded;
    [btn setTarget:self];
    [btn setAction:@selector(verify:)];
    [content addSubview:btn];

    [verifyWin makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}

void verify:(NSButton *)btn {
    NSTextField *tf = (NSTextField *)[[btn superview] viewWithTag:101];
    NSString *key = tf.stringValue?:@"";
    
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"验证结果";
    alert.informativeText = key.length > 0 ? [NSString stringWithFormat:@"卡密「%@」验证成功（模拟）", key] : @"请输入卡密！";
    [alert runModal];
}