//
//  NXTimeUnit.m
//  AFNetworking
//  相对时间转换工具,适合计算间隔与绝对时间戳的转换
//  Created by XXF on 2023/2/8.
/**
 用法如下:
 天转成毫秒
 long long m=NXTimeUnit.DAYS.toMillis(1);
 毫秒转成天
 long long m3=NXTimeUnit.MILLISECONDS.toDays(86400000);
 */


#import "NXTimeUnit.h"
#import "NXTimeUnit_NANOSECONDS.h"
#import "NXTimeUnit_MICROSECONDS.h"
#import "NXTimeUnit_MILLISECONDS.h"
#import "NXTimeUnit_SECONDS.h"
#import "NXTimeUnit_MINUTES.h"
#import "NXTimeUnit_HOURS.h"
#import "NXTimeUnit_DAYS.h"

@interface NXTimeUnit()

@end

@implementation NXTimeUnit


+ (NXTimeUnit *)NANOSECONDS{
    return NXTimeUnit_NANOSECONDS.new;
}

+ (NXTimeUnit *)MICROSECONDS{
    return NXTimeUnit_MICROSECONDS.new;
}

+ (NXTimeUnit *)MILLISECONDS{
    return NXTimeUnit_MILLISECONDS.new;
}

+ (NXTimeUnit *)SECONDS{
    return NXTimeUnit_SECONDS.new;
}

+ (NXTimeUnit *)MINUTES{
    return NXTimeUnit_MINUTES.new;
}


+ (NXTimeUnit *)HOURS{
    return NXTimeUnit_HOURS.new;
}

+ (NXTimeUnit *)DAYS{
    return NXTimeUnit_DAYS.new;
}

- (long long (^)(long long d))toNanos{
    return ^long long(long long d){
        return [self ___convertToNanos]*d;
    };
}
- (long long (^)(long long d))toMicros{
    return ^long long(long long d){
        return [self ___convertToNanos]*d/(1000);
    };
}
- (long long (^)(long long d))toMillis{
    return ^long long(long long d){
        return [self ___convertToNanos]*d/(1000*1000);
    };
}
- (long long (^)(long long d))toSeconds{
    return ^long long(long long d){
        return [self ___convertToNanos]*d/(1000*1000*1000);
    };
}
- (long long (^)(long long d))toMinutes{
    return ^long long(long long d){
        return [self ___convertToNanos]/((long long)1000*1000*1000*60);
    };
}
- (long long (^)(long long d))toHours{
    return ^long long(long long d){
        return [self ___convertToNanos]*d/((long long)1000*1000*1000*60*60);
    };
}
- (long long (^)(long long d))toDays{
    return ^long long(long long d){
        return [self ___convertToNanos]*d/((long long)1000*1000*1000*60*60*24);
    };
}
/**
 内部方法 转换成纳秒
 */
-(long long)___convertToNanos{
    return NSNotFound;
}
@end

