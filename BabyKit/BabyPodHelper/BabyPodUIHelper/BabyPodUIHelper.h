//
//  BabyPodUIHelper.h
//  Pods
//
//  Created by li hua on 2017/6/5.
//

#ifndef BabyPodUIHelper_h
#define BabyPodUIHelper_h



#if __has_include(<BabyPodUIHelper/BabyPodUIHelper.h>)

#import <BabyPodUIHelper/BabyShowHelper.h>
#import <BabyPodUIHelper/BabyEmptyViewHelper.h>
#import <BabyPodUIHelper/BabyFPSHelper.h>
#import <BabyPodUIHelper/BabyToastHelper.h>

#else

#import "BabyShowHelper.h" ///< 提示文字工具类
#import "BabyEmptyViewHelper.h" ///< 空白(无数据)页工具类
#import "BabyFPSHelper.h"        ///< 基于JPFPSStatus封装的,检测FPS帧数
#import "BabyToastHelper.h"      ///< 基于CRToast封装的,顶部弹出提示

#endif




#endif /* BabyPodUIHelper_h */
