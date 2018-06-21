//
//  BBToastManager.m
//  BabyKit
//
//  Created by li hua on 2018/6/20.
//

#import "BBToastManager.h"

@implementation BBToastManager

+(void)toastTitle:(NSString *)title
          message:(NSString *)message
        iconImage:(UIImage *)iconImage
        iconColor:(UIColor *)iconColor
       titleColor:(UIColor *)titleColor
     messageColor:(UIColor *)messageColor
  backgroundColor:(UIColor *)backgroundColor
         duration:(CGFloat)duration
   apperanceBlock:(void (^)(void))appearance
  completionBlock:(void (^)(void))completion{
    
    UIImage *image = iconImage;
    if ([iconImage isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:(NSString *)iconImage];
    }
    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey                       : @(1),
                                      kCRToastNotificationPresentationTypeKey   : @(1),
                                      kCRToastUnderStatusBarKey                 : @(0),
                                      kCRToastTextColorKey                      : titleColor,
                                      kCRToastBackgroundColorKey                : backgroundColor,
                                      kCRToastTextAlignmentKey                  : @(NSTextAlignmentLeft),
                                      kCRToastTimeIntervalKey                   : @(duration),
                                      kCRToastImageTintKey                      : iconColor,
                                      kCRToastTextShadowColorKey                : [UIColor grayColor],
                                      kCRToastSubtitleTextKey                   : message,
                                      kCRToastSubtitleTextColorKey              : messageColor,
                                      kCRToastSubtitleTextAlignmentKey          : @(NSTextAlignmentLeft),
                                      kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                      kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)} mutableCopy];
    if (image) {
        options[kCRToastImageKey] = image;
    }
    if (title) {
        options[kCRToastTextKey] = title;
    }
    
    [CRToastManager showNotificationWithOptions:options
                                 apperanceBlock:appearance
                                completionBlock:completion];
}

+(void)toastErrorTitle:(NSString *)title
               message:(NSString *)message
             iconImage:(UIImage *)iconImage
        apperanceBlock:(void (^)(void))appearance
       completionBlock:(void (^)(void))completion{
    UIImage *image = iconImage;
    if ([iconImage isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:(NSString *)iconImage];
    }
    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               : @(1),
                              kCRToastNotificationPresentationTypeKey   : @(1),
                              kCRToastUnderStatusBarKey                 : @(0),
                              kCRToastFontKey                            :[UIFont boldSystemFontOfSize:14],
                              kCRToastSubtitleFontKey                    :[UIFont boldSystemFontOfSize:12],
                              kCRToastTextColorKey                      : [UIColor whiteColor],
                              kCRToastBackgroundColorKey                : [UIColor colorWithRed:1 green:0 blue:0 alpha:0.99],
                              kCRToastTextAlignmentKey                  : @(NSTextAlignmentLeft),
                              kCRToastTimeIntervalKey                   : @(2),
                              kCRToastImageTintKey                      : [UIColor whiteColor],
                              kCRToastTextShadowColorKey                : [UIColor grayColor],
                              kCRToastSubtitleTextColorKey              : [UIColor whiteColor],
                              kCRToastSubtitleTextAlignmentKey          : @(NSTextAlignmentLeft),
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)} mutableCopy];
    if (image) {
        options[kCRToastImageKey] = image;
    }
    if (title) {
        options[kCRToastTextKey] = title;
    }
    if (message) {
        options[kCRToastSubtitleTextKey] = message;
    }
    [CRToastManager showNotificationWithOptions:options
                                 apperanceBlock:appearance
                                completionBlock:completion];
}


+(void)toastFailTitle:(NSString *)title
                 message:(NSString *)message
               iconImage:(UIImage *)iconImage
          apperanceBlock:(void (^)(void))appearance
         completionBlock:(void (^)(void))completion{
    UIImage *image = iconImage;
    if ([iconImage isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:(NSString *)iconImage];
    }
    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               : @(1),
                              kCRToastNotificationPresentationTypeKey   : @(1),
                              kCRToastUnderStatusBarKey                 : @(0),
                              kCRToastFontKey                            :[UIFont boldSystemFontOfSize:14],
                              kCRToastSubtitleFontKey                    :[UIFont boldSystemFontOfSize:12],
                              kCRToastTextColorKey                      : [UIColor whiteColor],
                              kCRToastBackgroundColorKey                : [UIColor grayColor],
                              kCRToastTextAlignmentKey                  : @(NSTextAlignmentLeft),
                              kCRToastTimeIntervalKey                   : @(2),
                              kCRToastImageTintKey                      : [UIColor whiteColor],
                              kCRToastTextShadowColorKey                : [UIColor grayColor],
                              kCRToastSubtitleTextColorKey              : [UIColor whiteColor],
                              kCRToastSubtitleTextAlignmentKey          : @(NSTextAlignmentLeft),
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)} mutableCopy];
    if (image) {
        options[kCRToastImageKey] = image;
    }
    if (title) {
        options[kCRToastTextKey] = title;
    }
    if (message) {
        if (!title) {
            options[kCRToastTextKey] = message;
            options[kCRToastTextColorKey] = [UIColor whiteColor];
        }
    }

    [CRToastManager showNotificationWithOptions:options
                                 apperanceBlock:appearance
                                completionBlock:completion];
    
}

+(void)toastOkTitle:(NSString *)title
            message:(NSString *)message
          iconImage:(UIImage *)iconImage
     apperanceBlock:(void (^)(void))appearance
    completionBlock:(void (^)(void))completion{
    UIImage *image = iconImage;
    if ([iconImage isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:(NSString *)iconImage];
    }
    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               : @(1),
                              kCRToastNotificationPresentationTypeKey   : @(1),
                              kCRToastUnderStatusBarKey                 : @(0),
                              kCRToastFontKey                            :[UIFont boldSystemFontOfSize:14],
                              kCRToastSubtitleFontKey                    :[UIFont boldSystemFontOfSize:12],
                              kCRToastTextColorKey                      : [UIColor whiteColor],
                              kCRToastBackgroundColorKey                : [UIColor colorWithRed:19.0/255 green:42.0 blue:30.0/255.0 alpha:1],
                              kCRToastTextAlignmentKey                  : @(NSTextAlignmentLeft),
                              kCRToastTimeIntervalKey                   : @(2),
                              kCRToastImageTintKey                      : [UIColor whiteColor],
                              kCRToastTextShadowColorKey                : [UIColor grayColor],
                              kCRToastSubtitleTextColorKey              : [UIColor whiteColor],
                              kCRToastSubtitleTextAlignmentKey          : @(NSTextAlignmentLeft),
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)} mutableCopy];
    
    if (image) {
        options[kCRToastImageKey] = image;
    }
    if (title) {
        options[kCRToastTextKey] = title;
    }
    if (message) {
        options[kCRToastSubtitleTextKey] = message;
    }
    [CRToastManager showNotificationWithOptions:options
                                 apperanceBlock:appearance
                                completionBlock:completion];
}

+(void)toastDismiss{
    [CRToastManager dismissAllNotifications:YES];
}

@end
