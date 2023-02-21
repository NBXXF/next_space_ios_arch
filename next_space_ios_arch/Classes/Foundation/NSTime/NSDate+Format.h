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


/**
 快速时间格式化 增加fast开头 易于提醒开发者
 */
- (NSString *)fastStringWithFormat:(NSString *)format;


/**
 快速时间格式化  增加fast开头 易于提醒开发者
 */
+ (NSString *)fastStringFormatWithTimeStamp:(long long)milliseconds withFormat:(NSString *)format;



/**
这个用于替换NSDate (YYAdd) 中的stringWithFormat 方法
*/
- (NSString *)stringWithFormat:(NSString *)format  DEPRECATED_MSG_ATTRIBUTE("请用fastStringWithFormat");

/**
 这是迁移来的老方法
 */
- (NSString *)timeToFormat:(NSString *)format DEPRECATED_MSG_ATTRIBUTE("请用fastStringWithFormat");

/**
 这是迁移来的老方法
 */
+ (NSString *)formatTimeStamp:(long long)timeStamp withFormat:(NSString *)format  DEPRECATED_MSG_ATTRIBUTE("请用fastStringFormatWithTimeStamp");


/**
 反格式化时间  增加fast开头 易于提醒开发者
 */
+ (nullable NSDate *)fastDateWithString:(NSString *)dateString format:(NSString *)format;



@end
