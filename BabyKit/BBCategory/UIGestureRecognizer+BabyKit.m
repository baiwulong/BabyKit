//
//  UIGestureRecognizer+BabyKit.m
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import "UIGestureRecognizer+BabyKit.h"
#import <objc/runtime.h>


/**
 --------------------------------------------------------------
 `UIGestureRecognizer`手势分类
 --------------------------------------------------------------
 */

#pragma mark - UIGestureRecognizer Category

@interface UIGestureRecognizer (HandleAction)

@property (nonatomic, assign) BOOL shouldHandleAction;

- (void)handleAction:(UIGestureRecognizer *)recognizer;

@end

/**
 --------------------------------------------------------------
 `UIGestureRecognizer`手势分类
 --------------------------------------------------------------
 */
@implementation UIGestureRecognizer (Gesture)

+ (id)gestureRecognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block{
    NSTimeInterval delay = 0.1;
    return [[[self class] alloc] initWithHandler:block delay:delay];
}


- (id)initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay{
    self = [self initWithTarget:self action:@selector(handleAction:)];
    if (!self) return nil;
    self.gestureHandler = block;
    self.gestureDelay = delay;
    return self;
}

- (void)gestureCancel{
    self.shouldHandleAction = NO;
}

- (void)handleAction:(UIGestureRecognizer *)recognizer{
    //获取手势的block属性
    void (^handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) = recognizer.gestureHandler;
    if (!handler){
        return;
    }
    //获取延时时间
    NSTimeInterval delay = self.gestureDelay;
    CGPoint location = [self locationInView:self.view];
    //定义block控制handler的执行
    void (^block)(void) = ^{
        if (!self.shouldHandleAction){
            return;
        }
        handler(self, self.state, location);
    };
    
    self.shouldHandleAction = YES;
    
    if (!delay) {
        block();
        return;
    }
    //延时执行block
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

#pragma mark - Setter And Getter (UIGestureRecognizer)

- (void)setGestureDelay:(NSTimeInterval)gestureDelay{
    NSNumber *delayValue = gestureDelay ? @(gestureDelay) : @(0.05);
    objc_setAssociatedObject(self, @selector(gestureDelay), delayValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)gestureDelay{
    return [objc_getAssociatedObject(self, @selector(gestureDelay)) doubleValue];
}

-(void)setGestureHandler:(void (^)(UIGestureRecognizer *, UIGestureRecognizerState, CGPoint))gestureHandler{
    objc_setAssociatedObject(self, @selector(gestureHandler), gestureHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))gestureHandler{
    return objc_getAssociatedObject(self, @selector(gestureHandler));
}

-(void)setShouldHandleAction:(BOOL)shouldHandleAction{
    objc_setAssociatedObject(self, @selector(shouldHandleAction), @(shouldHandleAction), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)shouldHandleAction{
    return [objc_getAssociatedObject(self, @selector(shouldHandleAction)) boolValue];
}

@end
