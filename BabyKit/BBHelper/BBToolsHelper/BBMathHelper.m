//
//  BBMathHelper.m
//  Pods
//
//  Created by li hua on 2016/6/14.
//

#import "BBMathHelper.h"

@implementation BBMathHelper

float MathDegreesToRadian(float angle){
    return M_PI * (angle) / 180.0;
}
float MathRadianToDegrees(float radian){
    return (radian*180.0)/(M_PI);
}

@end
