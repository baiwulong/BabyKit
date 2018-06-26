//
//  BabyHelper.h
//  Pods
//
//  Created by li hua on 2017/6/13.
//

#ifndef BabyHelper_h
#define BabyHelper_h

#if __has_include(<BabyHelper/BabyHelper.h>)

#import <BabyHelper/BabyColorHelper.h>
#import <BabyHelper/BabyUIHelper.h>

#import <BabyHelper/BabyRegExpHelper.h>
#import <BabyHelper/BabyFileHelper.h>
#import <BabyHelper/BabyMathHelper.h>

#else

#import "BabyColorHelper.h"
#import "BabyUIHelper.h"

#import "BabyRegExpHelper.h" //正则匹配类
#import "BabyFileHelper.h"   //文件管理类
#import "BabyMathHelper.h"   //数学相关

#endif



#endif /* BabyHelper_h */
