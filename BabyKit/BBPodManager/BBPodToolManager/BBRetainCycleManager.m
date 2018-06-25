//
//  BBRetainCycleManager.m
//  Pods
//
//  Created by li hua on 2017/6/19.
//

#import "BBRetainCycleManager.h"

void BBCycleDetector(id obj){
    [BBRetainCycleManager retainCycleDetect:obj];
}

@implementation BBRetainCycleManager

+(void)retainCycleDetect:(id)obj{
# if DEBUG
    NSLog(@"⚠️⚠️⚠️TMKit中使用了MLeaksFinder框架，只在Debug模式下起效，不用担心，假如有循环引用，会弹窗");
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:obj];
    NSSet *retainCycles = [detector findRetainCycles];
    if (retainCycles.count) {
        NSLog(@"\n❌❌❌发现可疑的循环引用(FBRetainCycleDetector在debug模式下)\n%@", retainCycles);
    }
#endif
}
@end
