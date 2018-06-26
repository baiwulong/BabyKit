//
//  UIGestureRecognizer+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 --------------------------------------------------------------
 `UIGestureRecognizer (TMKit)`手势分类
 --------------------------------------------------------------
 */

#pragma mark - UIGestureRecognizer Category

@interface UIGestureRecognizer (Gesture)

/// 手势处理block属性
@property (nonatomic, copy) void (^gestureHandler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location);
/// 手势延时间隔
@property (nonatomic,assign) NSTimeInterval gestureDelay;

/// 手势创建
+ (id)gestureRecognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;
/// 取消手势
- (void)gestureCancel;

@end


NS_ASSUME_NONNULL_END
