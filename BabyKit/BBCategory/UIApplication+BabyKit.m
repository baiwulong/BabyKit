//
//  UIApplication+BabyKit.m
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import "UIApplication+BabyKit.h"

@implementation UIApplication (AppInfo)


- (NSString *)appInfoBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSString *)appInfoBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

- (NSString *)appInfoVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)appInfoBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

-(BOOL)appInfoFirstTimeInstall{
    id isHadInstalled = [[NSUserDefaults standardUserDefaults] objectForKey:@"appInfoHadInstalledKey"];
    if (!isHadInstalled) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"appInfoHadInstalledKey"];
        return YES;
    }
    return NO;
}


@end
