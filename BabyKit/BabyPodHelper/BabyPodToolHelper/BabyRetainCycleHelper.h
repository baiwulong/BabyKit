//
//  BabyRetainCycleHelper.h
//  Pods
//
//  Created by li hua on 2017/6/19.
//

#import <Foundation/Foundation.h>
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>   ///< 自动检测循环引用
/// 快速检测循环引用
void BabyCycleDetector(id obj);

@interface BabyRetainCycleHelper : NSObject
+(void)retainCycleDetect:(id)obj;
@end
