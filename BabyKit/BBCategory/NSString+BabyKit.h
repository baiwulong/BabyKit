//
//  NSString+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (StringSize)

/**
 * 计算文本高度，width：最大宽度（根据这个限制来计算高度）
 */
-(CGSize)stringMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
