//
//  NSDate+Tool.m
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "NSDate+Format.h"
#import "NSDate+Helper.h"
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>


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
    return [self stringWithFormat:@"yyyy年MM月dd日"];
}


- (NSString *)string_yyyy_MM{
    return [self stringWithFormat:@"yyyy-MM-dd"];
}


- (NSString *)timeToFormat:(NSString *)format{
    return [self stringWithFormat:format];
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




+ (NSString *)formatTimeStamp:(long long)timeStamp withFormat:(NSString *)format {
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000];
    return [date stringWithFormat:format];
}


@end
