//
//  BabyKit.h
//  Pods
//
//  Created by li hua on 2017/6/5.
//

#ifndef BabyKit_h
#define BabyKit_h

#if __has_include(<BabyKit/BabyKit.h>)

#import <BabyKit/BabyHelper.h>              ///<常用帮助工具类(系统类封装)
#import <BabyKit/BabyPodHelper.h>           ///<常用Pod封装
#import <BabyKit/BabyCategory.h>            ///<常用自定义类别
#import <BabyKit/BabyCustomView.h>          ///<常用自定义视图

#else

#import "BabyHelper.h"                      ///<常用帮助工具类(系统类封装)
#import "BabyPodHelper.h"                   ///<常用Pod封装
#import "BabyCategory.h"                    ///<常用自定义类别
#import "BabyCustomView.h"                  ///<常用自定义视图

#endif



#endif /* BabyKit_h */
