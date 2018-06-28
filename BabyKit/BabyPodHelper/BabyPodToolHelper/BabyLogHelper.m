//
//  BabyLogHelper.m
//  BabyKit
//
//  Created by li hua on 2017/6/12.
//

#import "BabyLogHelper.h"

@implementation BabyCustomFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage->_flag) {
            case DDLogFlagError    : logLevel = @"❌❌❌错误日志⏬"; break;
            case DDLogFlagWarning  : logLevel = @"⚠️⚠️⚠️警告日志⏬"; break;
            case DDLogFlagInfo     : logLevel = @"✅✅✅打印日志⏬"; break;
            case DDLogFlagDebug    : logLevel = @"📶📶📶网络日志⏬"; break;
            default                : logLevel = @"⚙⚙⚙调试日志⏬"; break;
    }
    switch (logMessage->_flag) {
            case DDLogFlagError    :
                logMessage->_message = [NSString stringWithFormat:@"❌%@",logMessage->_message];break;
            case DDLogFlagWarning  :
                logMessage->_message = [NSString stringWithFormat:@"⚠️%@",logMessage->_message];break;
            case DDLogFlagInfo     :
                logMessage->_message = [NSString stringWithFormat:@"✅%@",logMessage->_message];break;
            case DDLogFlagDebug    :
                logMessage->_message = [NSString stringWithFormat:@"📶%@",logMessage->_message];break;
            default                :
                logMessage->_message = [NSString stringWithFormat:@"⚙%@",logMessage->_message];break;
    }
    
    return [NSString stringWithFormat:@"\n\n%@\nfileName:%@ \nfunction:%@ \nline:第%lu行\n日志信息:%@\n时间:%@\n==========================================\n", logLevel, logMessage->_fileName,logMessage.function,(unsigned long)logMessage.line,logMessage->_message,logMessage.timestamp];
}

@end

@implementation BabyLogHelper

static DDFileLogger *fileLogger;

+(void)logConfig{
    if (!fileLogger) {
        // 添加DDASLLogger，你的日志语句将被发送到Xcode控制台（iOS）
        [DDTTYLogger sharedInstance].logFormatter = [[BabyCustomFormatter alloc] init];
        
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        // 添加DDTTYLogger，你的日志语句将被发送到Console.app（MAC）
        //[DDLog addLogger:[DDASLLogger sharedInstance] withLevel:DDLogLevelWarning];
        
        // 添加DDFileLogger，你的日志语句将写入到一个文件中，默认路径在沙盒的Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log。
        fileLogger = [[DDFileLogger alloc] init];
        
        fileLogger.rollingFrequency = 60 * 60 * 24;
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        [DDLog addLogger:fileLogger];
        [self logFilePath];
    }
}

+(void)logFilePath{
    DDLogInfo(@"日志文件路径\n%@",fileLogger.currentLogFileInfo.filePath);
}

@end
