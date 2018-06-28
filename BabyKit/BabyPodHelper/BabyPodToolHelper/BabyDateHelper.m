//
//  BabyDateHelper.m
//  BabyKit
//
//  Created by li hua on 2017/6/13.
//

#import "BabyDateHelper.h"
@implementation BabyDateHelper

#pragma mark - 获取时间戳

//获取当前时间戳文本
+(NSString *)dateCurrentTimeStampString{
    return @([NSDate date].timeIntervalSince1970).stringValue;
}

//获取刚刚，几秒前等文本
+(NSString *)dateTimeAgoWithTimestampString:(NSString *)timestampString{
    NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSince1970:timestampString.integerValue];
    return timeAgoDate.timeAgoSinceNow;
}

//获取指定格式日期文本
+(NSString *)dateFormateWithTimestampString:(NSString *)timestampString formate:(NSString *)formate{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampString.integerValue];
    NSString *dateStringCustom1 = [date formattedDateWithFormat:formate];
    return dateStringCustom1;
}

#pragma mark - 获取时间戳

//获取当前时间戳
+(NSInteger)dateCurrentTimeStamp{
    return [NSDate date].timeIntervalSince1970;
}

//获取指定格式日期文本对应的时间戳
+(NSInteger)dateString:(NSString *)dateString formatString:(NSString *)formatString{
    NSDate *date = [NSDate dateWithString:dateString formatString:formatString];
    return date.timeIntervalSince1970;
}

@end
