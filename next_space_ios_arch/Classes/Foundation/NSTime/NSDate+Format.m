//
//  NSDate+Tool.m
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "NSDate+Format.h"
#import "NSDate+Helper.h"
#import <objc/runtime.h>
#import <next_space_ios_arch/NSDate+NXTools.h>
#import <next_space_ios_arch/NSObject+NXTools.h>


@implementation NSDate (Format)

- (BOOL)isSameDay:(NSDate*)anotherDate{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    NSDateComponents* components2 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}


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
        displayStr = [self stringWithFormat:@"yyyy年M月d日"];
        return displayStr;
    }else{
//        NSCalendar *calendar = [[self class] sharedCalendar];
//        NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
//                                                   fromDate:today
//                                                     toDate:self
//                                                    options:0];
//        NSInteger leftDayCount = [components day];
        ///当前时间戳
        long long caculateTime = [self timeIntervalSince1970];
        ///现在时间的0点时间戳
        long long todayZeroTime = today.startMillisOfDay/1000;

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
            NSString * timeStr = [self stringWithFormat:@"HH:mm"];
            if(displayStr){
                return [NSString stringWithFormat:@"%@ %@",displayStr,timeStr];
            }else{
                return timeStr;
            }
        }else{
            displayStr = [self stringWithFormat:@"M月d日"];
            NSString * timeStr = [self stringWithFormat:@"HH:mm"];
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
    NSMutableDictionary *cacheDateFormatterDict=[NSMutableDictionary toKindOfClassObjectOrNilFrom:objc_getAssociatedObject(self, _cmd)]?:[NSMutableDictionary dictionary];
    NSDateFormatter *cacheFormatter=[NSDateFormatter toKindOfClassObjectOrNilFrom:[cacheDateFormatterDict objectForKey:format]];
    if(!cacheFormatter){
        cacheFormatter=[[NSDateFormatter alloc] init];
        [cacheFormatter setDateFormat:format];
        [cacheFormatter setLocale:[NSLocale currentLocale]];
        [cacheDateFormatterDict setObject:cacheFormatter forKey:format];
        objc_setAssociatedObject(self, _cmd, cacheDateFormatterDict, OBJC_ASSOCIATION_RETAIN);
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
    return [[self ______getCacheDateFormatterWithFormat:format] dateFromString:format];
}

+ (NSDate *)fastDateFromString:(NSString *)dateString withFormat:(NSString *)format{
    return [self fastDateWithString:dateString withFormat:format];
}
@end
