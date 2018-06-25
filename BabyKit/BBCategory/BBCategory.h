//
//  BBCategory.h
//  Pods
//
//  Created by li hua on 2017/6/13.
//

#ifndef BBCategory_h
#define BBCategory_h

/// 如果是单独使用`BabyKit`的子组件`BBCategory`
#if __has_include(<BBCategory/BBCategory.h>)

#import <BBCategory/NSObject+BabyKit.h>
#import <BBCategory/NSString+BabyKit.h>
#import <BBCategory/UIImage+BabyKit.h>
#import <BBCategory/UIGestureRecognizer+BabyKit.h>
#import <BBCategory/UIApplication+BabyKit.h>
#import <BBCategory/UIView+BabyKit.h>
#import <BBCategory/UIScrollView+BabyKit.h>
#import <BBCategory/UITableView+BabyKit.h>

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
