//
//  NSString+BabyKit.m
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import "NSString+BabyKit.h"

/**
 --------------------------------------------------------------
 `NSString (StringSize)`计算获取文本高度
 --------------------------------------------------------------
 */

#pragma mark - NSString Category
@implementation NSString (StringSize)

-(CGSize)stringMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    if([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *tdic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
        size = [self boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:tdic
                                  context:nil].size;
    }else{
        //忽略编译器过期函数警告⚠️
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:[UIFont systemFontOfSize:fontSize]
                constrainedToSize:size
                    lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    return CGSizeMake(size.width, size.height+10);
}


@end
