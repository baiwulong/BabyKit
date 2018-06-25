//
//  BBKeyboardManager.m
//  BBKit
//
//  Created by li hua on 2017/6/20.
//

#import "BBKeyboardManager.h"

static BBKeyboardManager *sharedBBKeyboardManager = nil;

@implementation BBKeyboardManager

+(BBKeyboardManager *)sharedInstance{
    if (!sharedBBKeyboardManager) {
        sharedBBKeyboardManager = [[BBKeyboardManager alloc]init];
    }
    return sharedBBKeyboardManager;
}

-(void)configManager{
    self.manager = [IQKeyboardManager sharedManager];
    self.manager.enable = YES; // 控制整个功能是否启用
    self.manager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    self.manager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    self.manager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    self.manager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    self.manager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    self.manager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    self.manager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}


@end
