//
//  UIApplication+BabyKit.m
//  BabyKit
//
//  Created by li hua on 2018/6/25.
//

#import "UIApplication+BabyKit.h"

@implementation UIApplication (AppInfo)


- (NSString *)applicationBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSString *)applicationBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

- (NSString *)applicationVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)applicationBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

-(BOOL)applicationFirstTimeInstall{
    id isHadInstalled = [[NSUserDefaults standardUserDefaults] objectForKey:@"applicationHadInstalledKey"];
    if (!isHadInstalled) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"applicationHadInstalledKey"];
        return YES;
    }
    return NO;
}


@end
