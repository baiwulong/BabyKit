//
//  BBPodTool.h
//  Pods
//
//  Created by li hua on 2016/6/5.
//

#ifndef BBPodTool_h
#define BBPodTool_h



#pragma mark - 第三方工具类头文件引入
/**
 * #define MAS_SHORTHAND_GLOBALS使用全局宏定义，可以使equalTo等效于mas_equalTo
 * #define MAS_SHORTHAND使用全局宏定义, 可以在调用masonry方法的时候不使用mas_前缀
 */
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>     ///< Masonry约束框架
#import <CTMediator/CTMediator.h>     ///< 组件解耦方案

#pragma mark - 基于第三方工具类封装
#import "BBLogManager.h"        ///< 基于CocoaLumberjack封装系统日志工具管理类
#import "BBDateManager.h"       ///< 基于DateTools封装的时间日期工具管理类
#import "BBDatabaseManager.h"   ///< 基于FMDB封装的数据库管理类
#import "BBRetainCycleManager.h"///< 基于FBRetainCycleDetector封装的,检测某个类是否有循环引用问题
#import "BBKeyboardManager.h"   ///< 基于IQKeyboardManager封装的

#endif /* BBPodTool_h */
