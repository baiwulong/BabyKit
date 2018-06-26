//
//  BabyMathHelper.m
//  Pods
//
//  Created by li hua on 2017/6/14.
//

#import "BabyMathHelper.h"

@implementation BabyMathHelper

float MathDegreesToRadian(float angle){
    return M_PI * (angle) / 180.0;
}
float MathRadianToDegrees(float radian){
    return (radian*180.0)/(M_PI);
}

@end
