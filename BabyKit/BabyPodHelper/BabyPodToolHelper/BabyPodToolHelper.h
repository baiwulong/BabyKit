//
//  BabyPodToolHelper.h
//  Pods
//
//  Created by li hua on 2017/6/5.
//

#ifndef BabyPodToolHelper_h
#define BabyPodToolHelper_h


#if __has_include(<BabyPodToolHelper/BabyPodToolHelper.h>)

#import <BabyPodToolHelper/BabyLogHelper.h>
#import <BabyPodToolHelper/BabyDateHelper.h>
#import <BabyPodToolHelper/BabyDatabaseHelper.h>
#import <BabyPodToolHelper/BabyRetainCycleHelper.h>
#import <BabyPodToolHelper/BabyKeyboardHelper.h>

#else

#pragma mark - 基于第三方工具类封装
#import "BabyLogHelper.h"        ///< 基于CocoaLumberjack封装系统日志工具管理类
#import "BabyDateHelper.h"       ///< 基于DateTools封装的时间日期工具管理类
#import "BabyDatabaseHelper.h"   ///< 基于FMDB封装的数据库管理类
#import "BabyRetainCycleHelper.h"///< 基于FBRetainCycleDetector封装的,检测某个类是否有循环引用问题
#import "BabyKeyboardHelper.h"   ///< 基于IQKeyboardManager封装的

#endif


#endif /* BabyPodToolHelper_h */
