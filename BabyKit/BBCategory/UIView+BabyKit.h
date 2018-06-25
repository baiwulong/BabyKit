//
//  UIView+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import <UIKit/UIKit.h>
#import "UIGestureRecognizer+BabyKit.h"


NS_ASSUME_NONNULL_BEGIN

/**
 --------------------------------------------------------------
 `UIView (ViewFrame)`获取与设置view的frame相关数值
 --------------------------------------------------------------
 */

#pragma mark - UIView Category

@interface UIView (ViewFrame)

///位置:x
@property (nonatomic,assign) CGFloat viewX;

/// 位置:y
@property (nonatomic,assign) CGFloat viewY;

/// 中心点:x
@property (nonatomic,assign) CGFloat viewCenterX;

///中心点:y
@property (nonatomic,assign) CGFloat viewCenterY;

/// 宽:width
@property (nonatomic,assign) CGFloat viewWidth;

/// 高:height
@property (nonatomic,assign) CGFloat viewHeight;

/// 大小:CGSize结构
@property (nonatomic,assign) CGSize viewSize;

/// 位置:CGPoint位置
@property (nonatomic,assign) CGPoint viewOrigin;

@end


/**
 --------------------------------------------------------------
 `UIView (ChainResponder)`view事件响应链
 --------------------------------------------------------------
 */

#pragma mark - UIView Category (ChainResponder)

@interface UIView (ChainResponder)

/// 递归获取视图控制器
@property (nonatomic,strong,readonly) UIViewController *viewContrller;

@end



/**
 --------------------------------------------------------------
 `UIView (ActionBlock)`view手势事件，遍历子视图等
 --------------------------------------------------------------
 */

#pragma mark - UIView Category (ActionBlock)

@interface UIView (ActionBlock)

/// 单击执行代码块
- (void)actionTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/// 两个手指点击执行代码块
- (void)actionDoubleTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/// 滑动手势
-(void)actionSwipeDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

/// 遍历所有的子视图,并为每个子视图执行block代码
- (void)actionSubviewBlock:(void (^)(UIView *subview))block;

@end


NS_ASSUME_NONNULL_END
