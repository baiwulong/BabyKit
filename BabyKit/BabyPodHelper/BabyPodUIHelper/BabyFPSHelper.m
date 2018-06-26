//
//  BabyFPSHelper.m
//  CocoaLumberjack
//
//  Created by li hua on 2017/6/19.
//

#import "BabyFPSHelper.h"

@implementation BabyFPSHelper

+(void)fpsShow{
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
}

+(void)fpsHidden{
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] close];
#endif
}

@end
