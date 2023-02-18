//
//  NSDate+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/15.
//

#import <Foundation/Foundation.h>
#import "NSDate+NXTools.h"

@implementation NSDate(NXTools)

+ (long long)currentTimeMillis{
    return NSDate.now.milliseconds;
}

+ (NSString *)currentTimeMillisString{
    return [NSString stringWithFormat:@"%lld",self.currentTimeMillis];
}

- (NSInteger)dayOfYear{
    NSCalendar *cal = NSCalendar.currentCalendar;
    NSInteger dayInYear=[cal ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
    return dayInYear;
}

- (long long)milliseconds{
    return (long long)self.timeIntervalSince1970 * 1000;
}

- (long long)startMillisOfDay{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;

    NSDateComponents*zerocompents = [cal components:unitFlags fromDate:self];
    zerocompents.hour=0;
    zerocompents.minute=0;
    zerocompents.second=0;
    NSDate *newdate= [cal dateFromComponents:zerocompents];
    //需要精确到毫秒 23:59:59:000
    long long milliseconds = ((long long)newdate.timeIntervalSince1970)*1000;
    return milliseconds;
}

- (long long)endMillisOfDay{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;

    NSDateComponents*zerocompents = [cal components:unitFlags fromDate:self];
    zerocompents.hour=23;
    zerocompents.minute=59;
    zerocompents.second=59;
    NSDate *newdate= [cal dateFromComponents:zerocompents];
    //需要精确到毫秒 23:59:59:999
    long long milliseconds = ((long long)newdate.timeIntervalSince1970)*1000+999;
    return milliseconds;
}
@end
