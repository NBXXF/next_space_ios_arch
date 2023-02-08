//
//  NXTimeUnit.h
//  AFNetworking
//  相对时间转换工具,适合计算间隔与绝对时间戳的转换
//  Created by XXF on 2023/2/8.
/**
 支持纳秒,微秒,毫秒,秒,分,时,天各种交叉转换
 用法如下:
 天转成毫秒
 long long m=NXTimeUnit.DAYS.toMillis(1);
 毫秒转成天
 long long m3=NXTimeUnit.MILLISECONDS.toDays(86400000);
 */


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXTimeUnit : NSObject
@property(nonatomic,strong,readonly,class)  NXTimeUnit *NANOSECONDS;
@property(nonatomic,strong,readonly,class)  NXTimeUnit *MICROSECONDS;
@property(nonatomic,strong,readonly,class)  NXTimeUnit *MILLISECONDS;
@property(nonatomic,strong,readonly,class)  NXTimeUnit *SECONDS;
@property(nonatomic,strong,readonly,class)  NXTimeUnit *MINUTES;
@property(nonatomic,strong,readonly,class)  NXTimeUnit *HOURS;
@property(nonatomic,strong,readonly,class)  NXTimeUnit *DAYS;


/**
 -(long)toNanos:(long)d;
 -(long)toMicros:(long)d;
 -(long)toMillis:(long)d;
 -(long)toSeconds:(long)d;
 -(long)toMinutes:(long)d;
 -(long)toHours:(long)d;
 -(long)toDays:(long)d;
 */

- (long long (^)(long long d))toNanos;
- (long long (^)(long long d))toMicros;
- (long long (^)(long long d))toMillis;
- (long long (^)(long long d))toSeconds;
- (long long (^)(long long d))toMinutes;
- (long long (^)(long long d))toHours;
- (long long (^)(long long d))toDays;

/**
 内部方法 转换成纳秒
 */
-(long long)___convertToNanos;
@end

NS_ASSUME_NONNULL_END
