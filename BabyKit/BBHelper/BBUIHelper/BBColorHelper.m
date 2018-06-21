//
//  BBColorHelper.m
//  Pods
//
//  Created by li hua on 2016/6/14.
//

#import "BBColorHelper.h"

@implementation BBColorHelper

UIColor *rgbColor(float red,float green,float blue){
    return [UIColor colorWithRed:(red)/255.0 green:(green)/255.0 blue:(blue)/255.0 alpha:1.0];
}

UIColor *rgbaColor(float red,float green,float blue,float alpha){
    return [UIColor colorWithRed:(red)/255.0 green:(green)/255.0 blue:(blue)/255.0 alpha:alpha];
}

/// 传递一个value，rgb值(value)相同的颜色
UIColor *rgbsColor(float value){
    return [UIColor colorWithRed:(value)/255.0 green:(value)/255.0 blue:(value)/255.0 alpha:1.0];
}

/// 传递一个颜色16进制字符串，返回特定的颜色
UIColor *rgbHexString(NSString * hexString){
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

UIColor *whiteColor(void){
    return [UIColor whiteColor];
}
UIColor *redColor(void){
    return [UIColor redColor];
}
UIColor *yellowColor(void){
    return [UIColor yellowColor];
}
UIColor *greenColor(void){
    return [UIColor greenColor];
}
UIColor *blueColor(void){
    return [UIColor blueColor];
}
UIColor *blueAlipayColor(void){
    return [UIColor colorWithRed:(0)/255.0 green:(152)/255.0 blue:(229)/255.0 alpha:1.0];
}
UIColor *clearColor(void){
    return [UIColor clearColor];
}
UIColor *orangeColor(void){
    return [UIColor orangeColor];
}
UIColor *blackColor(void){
    return [UIColor blackColor];
}
UIColor *lightGrayColor(void){
    return [UIColor lightGrayColor];
}
UIColor *brownColor(void){
    return [UIColor brownColor];
}
UIColor *purpleColor(void){
    return [UIColor purpleColor];
}
UIColor *grayColor(void){
    return [UIColor grayColor];
}
UIColor *gray03Color(void){
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}
UIColor *gray227Color(void){
    return [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.3];
}

+(UIColor *)colorRandomColor{
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}

+(UIColor *)colorHexString:(NSString *)hexColor{
    return rgbHexString(hexColor);
}

@end
