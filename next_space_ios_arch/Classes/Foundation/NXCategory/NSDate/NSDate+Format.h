//
//  NSDate+Tool.h
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

- (BOOL)isSameDay:(NSDate*)anotherDate;


- (NSInteger)hoursAgo;
- (NSInteger)daysAgo;

- (NSString *)string_yyyy_MM;
- (NSString *)stringyyyyMMdd;


///显示前天昨天今天明天后天的显示
- (NSString *)getLatestDayStr;


- (NSString *)timeToFormat:(NSString *)format;

+ (NSString *)formatTimeStamp:(long long)timeStamp withFormat:(NSString *)format;

@end
