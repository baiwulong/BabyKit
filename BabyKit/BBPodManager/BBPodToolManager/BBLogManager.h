//
//  BBLogManager.h
//  TMKit
//
//  Created by li hua on 2016/6/12.
//

#import <Foundation/Foundation.h>

#define LOG_LEVEL_DEF ddLogLevel
#import <CocoaLumberjack/CocoaLumberjack.h>

/**
 --------------------------------------------------------------
 宏定义
 --------------------------------------------------------------
 */

///设置全局日志级别
#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif

/// CocoaLumberjack默认为0 ，自定义自行设置
#define LOG_CONTEXT_TM 100



/**
 --------------------------------------------------------------
 `BBLogManager`基于CocoaLumberjack的日志管理类，打印日志，保存日志文件：默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log
 --------------------------------------------------------------
 */


/// 信息日志✅
#define BBLog(frmt, ...)\
({\
[BBLogManager logConfig];\
LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagInfo, LOG_CONTEXT_TM, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__);\
})

/// 信息日志✅
#define BBLogInfo(frmt, ...)\
({\
[BBLogManager logConfig];\
LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagInfo, LOG_CONTEXT_TM, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__);\
})

/// 网络日志📶
#define BBLogNetworkDebug(frmt, ...)\
({\
[BBLogManager logConfig];\
LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagDebug,  LOG_CONTEXT_TM, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__);\
})

/// 错误日志❌
#define BBLogError(frmt, ...)\
({\
[BBLogManager logConfig];\
LOG_MAYBE(NO,LOG_LEVEL_DEF, DDLogFlagError, LOG_CONTEXT_TM, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__);\
})

/// 警告日志⚠️
#define BBLogWarn(frmt, ...)\
({\
[BBLogManager logConfig];\
LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagWarning, LOG_CONTEXT_TM, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__);\
})

/// 全部日志⚙
#define BBLogVerbose(frmt, ...)\
({\
[BBLogManager logConfig];\
LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, DDLogFlagVerbose, LOG_CONTEXT_TM, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__);\
})



@interface BBLogManager : NSObject

/**
 *  @brief 初始化日志框架
 */
+(void)logConfig;

/**
 *  @brief 日志保存的目录路径
 */
+(void)logFilePath;
@end


/**
 --------------------------------------------------------------
 `BBCustomFormatter`自定义日志显示格式
 --------------------------------------------------------------
 */
@interface BBCustomFormatter : NSObject<DDLogFormatter>

@end
