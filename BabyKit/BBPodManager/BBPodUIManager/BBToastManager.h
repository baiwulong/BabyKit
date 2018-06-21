//
//  BBToastManager.h
//  BBKit
//
//  Created by li hua on 2018/6/20.
//

#import <Foundation/Foundation.h>
#import <CRToast/CRToast.h>

@interface BBToastManager : NSObject

/// 自定义颜色样式
+(void)toastTitle:(NSString *)title
          message:(NSString *)message
        iconImage:(UIImage *)iconImage
        iconColor:(UIColor *)iconColor
       titleColor:(UIColor *)titleColor
     messageColor:(UIColor *)messageColor
  backgroundColor:(UIColor *)backgroundColor
         duration:(CGFloat)duration
   apperanceBlock:(void (^)(void))appearance
  completionBlock:(void (^)(void))completion;

/// 红色样式
+(void)toastErrorTitle:(NSString *)title
               message:(NSString *)message
             iconImage:(UIImage *)iconImage
        apperanceBlock:(void (^)(void))appearance
       completionBlock:(void (^)(void))completion;

/// 灰色样式
+(void)toastFailTitle:(NSString *)title
               message:(NSString *)message
             iconImage:(UIImage *)iconImage
        apperanceBlock:(void (^)(void))appearance
       completionBlock:(void (^)(void))completion;

/// 绿色样式
+(void)toastOkTitle:(NSString *)title
                 message:(NSString *)message
               iconImage:(UIImage *)iconImage
          apperanceBlock:(void (^)(void))appearance
         completionBlock:(void (^)(void))completion;

+(void)toastDismiss;

@end
