//
//  BabyColorHelper.h
//  Pods
//
//  Created by li hua on 2017/6/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 --------------------------------------------------------------
 `BabyColorHelper`颜色管理类，C方法快速调用
 --------------------------------------------------------------
 */
@interface BabyColorHelper : NSObject

///c函数类定义快速调用创建颜色
UIColor *rgbColor(float red,float green,float blue);
///c函数类定义快速调用创建颜色(含alpha值)
UIColor *rgbaColor(float red,float green,float blue,float alpha);
/// 传递一个value，rgb值(value)相同的颜色
UIColor *rgbsColor(float value);
/// 传递一个颜色16进制字符串，返回特定的颜色
UIColor *rgbHexString(NSString * hexString);


/// 白色
UIColor *whiteColor(void);
/// 红色
UIColor *redColor(void);
/// 黄色
UIColor *yellowColor(void);
/// 绿色
UIColor *greenColor(void);
/// 蓝色
UIColor *blueColor(void);
/// 支付宝蓝
UIColor *blueAlipayColor(void);
/// 透明色
UIColor *clearColor(void);
/// 橙色
UIColor *orangeColor(void);
/// 黑色
UIColor *blackColor(void);
/// 棕色
UIColor *brownColor(void);
/// 紫色
UIColor *purpleColor(void);
/// 灰色
UIColor *grayColor(void);
/// 浅灰色
UIColor *lightGrayColor(void);
/// 灰色透明0.3
UIColor *gray03Color(void);
/// 浅灰色背景色
UIColor *gray227Color(void);



/// 随机颜色
+(UIColor *)colorRandomColor;

/// 创建颜色（通过十六进制颜色值，#开头）
+(UIColor *)colorHexString:(NSString *)hexColor;

@end
