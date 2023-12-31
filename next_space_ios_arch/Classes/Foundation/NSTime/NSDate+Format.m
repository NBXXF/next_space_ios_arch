//
//  NSDate+Tool.m
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "NSDate+Format.h"
#import <next_space_ios_arch/NSObject+NXAssociation.h>
#import <next_space_ios_arch/NSDate+NXTools.h>
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <next_space_ios_arch/NSDate+Utilities.h>


@implementation NSDate (Format)


- (NSInteger)hoursAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components hour];
}



- (NSInteger)daysAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}





- (NSString *)stringyyyyMMdd{
    return [self fastStringWithFormat:@"yyyy年MM月dd日"];
}


- (NSString *)string_yyyy_MM{
    return [self fastStringWithFormat:@"yyyy-MM-dd"];
}



- (NSString *)getLatestDayStr{
    NSString *displayStr = @"";
    NSDate *today = [NSDate date];
    if ([self year] != [today year]) {
        displayStr = [self fastStringWithFormat:@"yyyy年M月d日"];
        return displayStr;
    }else{
        ///当前时间戳
        long long caculateTime = [self timeIntervalSince1970];
        ///现在时间的0点时间戳
        long long todayZeroTime = today.beginningOfDay.timeIntervalSince1970;

        long long perDaySecond = 60*60*24;
        
        ///今天0点时间戳 减去两天  要小于传进来的时间  或者今天0时间戳+两天要大于需要计算的时间戳
        if(todayZeroTime - 2* perDaySecond < caculateTime  && todayZeroTime + 2*perDaySecond > caculateTime){
            if(caculateTime >= todayZeroTime){
                if(caculateTime < todayZeroTime + perDaySecond){
                    displayStr = @"今天";
                }else if (caculateTime < todayZeroTime + 2* perDaySecond){
                    displayStr = @"明天";
                }else if (caculateTime < todayZeroTime + 3* perDaySecond){
                    displayStr = @"后天";
                }
            }else{
                if(caculateTime >= todayZeroTime - perDaySecond){
                    displayStr = @"昨天";
                }else if (caculateTime >= todayZeroTime - 2* perDaySecond){
                    displayStr = @"前天";
                }
            }
            NSString * timeStr = [self fastStringWithFormat:@"HH:mm"];
            if(displayStr){
                return [NSString stringWithFormat:@"%@ %@",displayStr,timeStr];
            }else{
                return timeStr;
            }
        }else{
            displayStr = [self fastStringWithFormat:@"M月d日"];
            NSString * timeStr = [self fastStringWithFormat:@"HH:mm"];
            return [NSString stringWithFormat:@"%@ %@",displayStr,timeStr];
        }
    }
}

- (NSString *)fastStringWithFormat:(NSString *)format{
    return [[NSDate ______getCacheDateFormatterWithFormat:format] stringFromDate:self];
}

+ (NSString *)fastStringFormatWithTimeStamp:(long long)milliseconds withFormat:(NSString *)format{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:milliseconds / 1000];
    return [[NSDate ______getCacheDateFormatterWithFormat:format] stringFromDate:date];
}

/**
 内部缓存的时间格式类
 */
+(NSDateFormatter *)______getCacheDateFormatterWithFormat:(NSString *)format{
    NSMutableDictionary *cacheDateFormatterDict=[NSMutableDictionary toKindOfClassObjectOrNilFrom:[self nx_getAssociatedObject:NSStringFromSelector(_cmd)]]?:[NSMutableDictionary dictionary];
    NSDateFormatter *cacheFormatter=[NSDateFormatter toKindOfClassObjectOrNilFrom:[cacheDateFormatterDict objectForKey:format]];
    if(!cacheFormatter){
        cacheFormatter=[[NSDateFormatter alloc] init];
        [cacheFormatter setDateFormat:format];
        [cacheFormatter setLocale:[NSLocale currentLocale]];
        [cacheDateFormatterDict setObject:cacheFormatter forKey:format];
        [self nx_setAssociatedObject:cacheDateFormatterDict forKey:NSStringFromSelector(_cmd)];
    }
#if DEBUG
    NSAssert(cacheDateFormatterDict.count<=500, @"业务乱传format,为了保证缓存 请传有效的时间格式,避免过多缓存");
#endif
    return cacheFormatter;
}

/**
这个用于替换NSDate (YYAdd) 中的stringWithFormat 方法
*/
- (NSString *)stringWithFormat:(NSString *)format  DEPRECATED_MSG_ATTRIBUTE("请用fastStringWithFormat"){
    return [self fastStringWithFormat:format];
}

/**
 这是迁移来的老方法
 */
- (NSString *)timeToFormat:(NSString *)format DEPRECATED_MSG_ATTRIBUTE("请用fastStringWithFormat"){
    return [self fastStringWithFormat:format];
}

/**
 这是迁移来的老方法
 */
+ (NSString *)formatTimeStamp:(long long)timeStamp withFormat:(NSString *)format DEPRECATED_MSG_ATTRIBUTE ("请用fastStringFormatWithTimeStamp") {
    return [self fastStringFormatWithTimeStamp:timeStamp withFormat:format];
}


+ (NSDate *)fastDateWithString:(NSString *)dateString withFormat:(NSString *)format{
    NSDateFormatter *formatter = [self sharedDateFormatter];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
  
    /**
     这里有问题
    NSDate *startDate = [NSDate fastDateFromString:startStr withFormat:startStr.length > 10 ? @"yyyy/MM/dd HH:mm" : @"yyyy/MM/dd"];
     */
  //  return [[self ______getCacheDateFormatterWithFormat:format] dateFromString:format];
}

+ (NSDate *)fastDateFromString:(NSString *)dateString withFormat:(NSString *)format{
    return [self fastDateWithString:dateString withFormat:format];
}

/**
这个用于替换NSDate (YYAdd) 中的dateWithString 方法
*/
+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format DEPRECATED_MSG_ATTRIBUTE("请用fastDateWithString or fastDateFromString"){
    return [self fastDateWithString:dateString withFormat:format];
}
/**
这个用于替换NSDate (YYAdd) 中的dateWithString 方法
*/
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format DEPRECATED_MSG_ATTRIBUTE("请用fastDateWithString or fastDateFromString"){
    return [self fastDateWithString:dateString withFormat:format];
}

@end
