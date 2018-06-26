//
//  BabyCategory.h
//  Pods
//
//  Created by li hua on 2017/6/13.
//

#ifndef BabyCategory_h
#define BabyCategory_h

/// 如果是单独使用`BabyKit`的子组件`BabyCategory`
#if __has_include(<BabyCategory/BabyCategory.h>)

#import <BabyCategory/NSObject+BabyKit.h>
#import <BabyCategory/NSString+BabyKit.h>
#import <BabyCategory/UIImage+BabyKit.h>
#import <BabyCategory/UIGestureRecognizer+BabyKit.h>
#import <BabyCategory/UIApplication+BabyKit.h>
#import <BabyCategory/UIView+BabyKit.h>
#import <BabyCategory/UIScrollView+BabyKit.h>
#import <BabyCategory/UITableView+BabyKit.h>

#else

/// 如果是使用`BabyKit`
#import "NSObject+BabyKit.h"
#import "NSString+BabyKit.h"
#import "UIImage+BabyKit.h"
#import "UIGestureRecognizer+BabyKit.h"
#import "UIApplication+BabyKit.h"
#import "UIView+BabyKit.h"
#import "UIScrollView+BabyKit.h"
#import "UITableView+BabyKit.h"

#endif

#endif
