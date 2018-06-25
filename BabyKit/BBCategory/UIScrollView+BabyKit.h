//
//  UIScrollView+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 拷贝YYKit😄

@interface UIScrollView (BabyKit)

/**
 Scroll content to top with animation.
 */
- (void)scrollToTop;

/**
 Scroll content to bottom with animation.
 */
- (void)scrollToBottom;

/**
 Scroll content to left with animation.
 */
- (void)scrollToLeft;

/**
 Scroll content to right with animation.
 */
- (void)scrollToRight;

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)scrollToTopAnimated:(BOOL)animated;

/**
 Scroll content to bottom.
 
 @param animated  Use animation.
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 Scroll content to left.
 
 @param animated  Use animation.
 */
- (void)scrollToLeftAnimated:(BOOL)animated;

/**
 Scroll content to right.
 
 @param animated  Use animation.
 */
- (void)scrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

