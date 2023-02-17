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

@end
