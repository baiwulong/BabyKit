//
//  BabyDateHelper.h
//  BabyKit
//
//  Created by li hua on 2017/6/13.
//

#import <Foundation/Foundation.h>
#import <DateTools/DateTools.h>

@interface BabyDateHelper : NSObject

/**
 *
 *  @brief 获取当前时间戳
 */
+(NSInteger)dateCurrentTimeStamp;

/**
 *
 *  @brief 获取当前时间戳
 */
+(NSString *)dateCurrentTimeStampString;

/**
 *
 *  @brief 获取格式日期如2016-10-10对应的时间戳。需要传入对应格式字符串，如yyyy-MM-dd
 */
+(NSInteger)dateString:(NSString *)dateString formatString:(NSString *)formatString;

/**
 *
 *  @brief 传一个时间戳字符串，和需要显示的格式字符串，返回对应格式的字符串
 *  @return 如yyyy-MM-dd,则返回2016-10-10
 */
+(NSString *)dateFormateWithTimestampString:(NSString *)timestampString formate:(NSString *)formate;

/**
 *
 *  @brief 传一个时间戳字符串参数，返回一个字符串：刚刚，几秒前，等
 *  @return 返回一个字符串：刚刚，几秒前，等
 */
+(NSString *)dateTimeAgoWithTimestampString:(NSString *)timestampString;




//格式字符    说明
//yy    年的后2位
//yyyy    完整年
//M    1~12 月(不带0)
//MM    1~12 月(带0)
//MMM    Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec (1~12月_简写)
//MMMM    January/February/March/April/May/June/July/August/September/October/November/December (1~12月_全写)
//d    1~31 日(不带0)
//dd    1~31 日(带0)
//EEE    Sun/Mon/Tue/Wed/Thu/Fri/Sat (星期_简写)
//EEEE    Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday (星期_全写)
//aa    AM/PM (上午/下午)
//H    0~23 时(24小时制,不带0)
//HH    0~23 时(24小时制,带0)
//h    1~12 时(12小时制,不带0)
//hh    1~12 时(24小时制,带0)
//m    0~59 分(不带0)
//mm    0~59 分(带0)
//s    0~59 秒(不带0)
//ss    0~59 秒(带0)
//S    毫秒


@end
