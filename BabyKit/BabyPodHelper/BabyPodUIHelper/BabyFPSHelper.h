//
//  BabyFPSHelper.h
//  CocoaLumberjack
//
//  Created by li hua on 2017/6/19.
//

#import <Foundation/Foundation.h>
#import <JPFPSStatus/JPFPSStatus.h>

@interface BabyFPSHelper : NSObject

/// bebug模式下，状态栏显示fps帧数
+(void)fpsShow;

/// bebug模式下，状态栏隐藏fps帧数
+(void)fpsHidden;

@end
