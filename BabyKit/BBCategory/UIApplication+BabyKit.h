//
//  UIApplication+BabyKit.h
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 参考YYKit😄

@interface UIApplication (AppInfo)


/// Application's Bundle Name (show in SpringBoard).
@property (nullable, nonatomic, readonly) NSString *appInfoBundleName;

/// APP的BundleID，如 "com.xxx.MyApp"
@property (nullable, nonatomic, readonly) NSString *appInfoBundleID;

/// APP的版本号，如 0.1.0
@property (nullable, nonatomic, readonly) NSString *appInfoVersion;

/// APP的build号，如 2
@property (nullable, nonatomic, readonly) NSString *appInfoBuildVersion;

/// APP是否是第一次安装
@property (nonatomic, assign, readonly) BOOL appInfoFirstTimeInstall;


@end

NS_ASSUME_NONNULL_END

