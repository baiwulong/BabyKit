//
//  BabyRetainCycleHelper.m
//  Pods
//
//  Created by li hua on 2017/6/19.
//

#import "BabyRetainCycleHelper.h"

void BabyCycleDetector(id obj){
    [BabyRetainCycleHelper retainCycleDetect:obj];
}

@implementation BabyRetainCycleHelper

+(void)retainCycleDetect:(id)obj{
# if DEBUG
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:obj];
    NSSet *retainCycles = [detector findRetainCycles];
    if (retainCycles.count) {
        NSLog(@"\n❌❌❌发现可疑的循环引用(FBRetainCycleDetector在debug模式下)\n%@", retainCycles);
    }
#endif
}
@end
