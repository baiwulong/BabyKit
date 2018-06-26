//
//  UIImage+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 拷贝YYKit😄
@interface UIImage (BabyKit)

- (nullable UIImage *)imageByResizeToSize:(CGSize)size;

- (nullable UIImage *)imageByCropToRect:(CGRect)rect;

- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor;

- (nullable UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(nullable UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;

- (nullable UIImage *)imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

@end

NS_ASSUME_NONNULL_END
