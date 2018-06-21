//
//  BBFPSManager.m
//  CocoaLumberjack
//
//  Created by li hua on 2016/6/19.
//

#import "BBFPSManager.h"

@implementation BBFPSManager

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
