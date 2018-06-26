//
//  UIView+BabyKit.m
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import "UIView+BabyKit.h"




/**
 --------------------------------------------------------------
 `UIView (ViewFrame)`UIView分类
 --------------------------------------------------------------
 */

#pragma mark - UIView (ViewFrame)

@implementation UIView (ViewFrame)

#pragma mark - Setter And Getter (UIView)

- (void)setViewX:(CGFloat)viewX{
    CGRect frame = self.frame;
    frame.origin.x = viewX;
    self.frame = frame;
}

- (CGFloat)viewX{
    return self.frame.origin.x;
}

- (void)setViewY:(CGFloat)viewY{
    CGRect frame = self.frame;
    frame.origin.y = viewY;
    self.frame = frame;
}

- (CGFloat)viewY{
    return self.frame.origin.y;
}

-(void)setViewWidth:(CGFloat)viewWidth {
    CGRect frame = self.frame;
    frame.size.width = viewWidth;
    self.frame = frame;
}

- (CGFloat)viewWidth{
    return self.frame.size.width;
}

- (void)setViewHeight:(CGFloat)viewHeight{
    CGRect frame = self.frame;
    frame.size.height = viewHeight;
    self.frame = frame;
}

- (CGFloat)viewHeight{
    return self.frame.size.height;
}

- (void)setViewSize:(CGSize)viewSize {
    CGRect frame = self.frame;
    frame.size = viewSize;
    self.frame = frame;
}

- (CGSize)viewSize{
    return self.frame.size;
}

- (void)setViewOrigin:(CGPoint)viewOrigin {
    CGRect frame = self.frame;
    frame.origin = viewOrigin;
    self.frame = frame;
}

- (CGPoint)viewOrigin{
    return self.frame.origin;
}

- (void)setViewCenterX:(CGFloat)viewCenterX{
    CGPoint center = self.center;
    center.x = viewCenterX;
    self.center = center;
}

- (CGFloat)viewCenterX{
    return self.center.x;
}

-(void)setViewCenterY:(CGFloat)viewCenterY{
    CGPoint center = self.center;
    center.y = viewCenterY;
    self.center = center;
}

- (CGFloat)viewCenterY{
    return self.center.y;
}


@end






/**
 --------------------------------------------------------------
 `UIView (ChainResponder)`UIView分类
 --------------------------------------------------------------
 */

#pragma mark - UIView (ChainResponder)

@implementation UIView (ChainResponder)

/// 获取view的控制器
-(UIViewController *)viewContrller{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

@end






/**
 --------------------------------------------------------------
 `UIView (View)`UIView分类
 --------------------------------------------------------------
 */

#pragma mark - UIView (ViewBlock)

@implementation UIView (ViewBlock)

/// 添加单击手势
- (void)viewTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    if (!block) return;
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer gestureRecognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if (state == UIGestureRecognizerStateRecognized){
            block(sender,state,location);
        }
    }];
    gesture.numberOfTouchesRequired = 1;
    gesture.numberOfTapsRequired = 1;
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]){
            return;
        }
        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == 1);
        BOOL rightTaps = (tap.numberOfTapsRequired == 1);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];
    [self addGestureRecognizer:gesture];
}

/// 添加双击手势
- (void)viewDoubleTappedBlock:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    if (!block) return;
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer gestureRecognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if (state == UIGestureRecognizerStateRecognized){
            block(sender,state,location);
        }
    }];
    gesture.numberOfTouchesRequired = 2;
    gesture.numberOfTapsRequired = 1;
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]){
            return;
        }
        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == 2);
        BOOL rightTaps = (tap.numberOfTapsRequired == 1);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];
    [self addGestureRecognizer:gesture];
}

/// 添加滑动手势
-(void)viewSwipeDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UISwipeGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    if (!block) return;
    UISwipeGestureRecognizer *swipe = [UISwipeGestureRecognizer gestureRecognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        block((UISwipeGestureRecognizer *)sender,state,location);
    }];
    swipe.direction = direction;
    [self addGestureRecognizer:swipe];
}

/// 遍历子视图
- (void)viewSubviewBlock:(void (^)(UIView *subview))block{
    if (!block) return;
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        block(subview);
    }];
}


@end



