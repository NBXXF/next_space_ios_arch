//
//  NSDate+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/15.
//

#import <Foundation/Foundation.h>
#import "NSDate+NXTools.h"

@implementation NSDate(NXTools)

- (NSInteger)dayOfYear{
    NSCalendar *cal = NSCalendar.currentCalendar;
    NSInteger dayInYear=[cal ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self];
    return dayInYear;
}

@end
