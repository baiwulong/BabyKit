//
//  BBRetainCycleManager.h
//  Pods
//
//  Created by li hua on 2016/6/19.
//

#import <Foundation/Foundation.h>
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>   ///< 自动检测循环引用
/// 快速检测循环引用
void BBCycleDetector(id obj);

@interface BBRetainCycleManager : NSObject
+(void)retainCycleDetect:(id)obj;
@end
