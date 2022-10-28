//
//  NSObject+RateLimiting.m
//  JLRoutes
//  时间维度节流或者防暴力点击工具
//  Created by XXF on 2022/10/24.
//

#import "NSObject+RateLimiting.h"
#import <objc/runtime.h>

@implementation NSObject (RateLimiting)

const char *THROTTLE_DATA_KEY = "THROTTLE_DATA_KEY";

- (NSMutableDictionary *)getThrottleData {
    NSMutableDictionary *throttleData = objc_getAssociatedObject(self, THROTTLE_DATA_KEY);
    
    if(!throttleData) {
        throttleData = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, THROTTLE_DATA_KEY, throttleData, OBJC_ASSOCIATION_RETAIN);
    }
    
    return throttleData;
}

- (void)throttleWithBlock:(void (^)(void))block duration:(NSTimeInterval)duration{
    if(![self isRateLimitingWithDuration:duration]){
        block();
    }
}


- (void)throttleWithSelector:(nonnull SEL)action withObject:(nullable id)object duration:(NSTimeInterval)duration {
    NSMutableDictionary *throttleData = [self getThrottleData];

    NSDate *lastCalled = [throttleData objectForKey:NSStringFromSelector(action)];
    
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [throttleData setObject:[NSDate date] forKey:NSStringFromSelector(action)];
        __weak typeof(self) weakSelf = self;
        [weakSelf performSelector:action withObject:object];
    }
}


- (void)throttleWithSelector:(SEL)action withObject:(id)object1 withObject:(id)object2 duration:(NSTimeInterval)duration{
    NSMutableDictionary *throttleData = [self getThrottleData];

    NSDate *lastCalled = [throttleData objectForKey:NSStringFromSelector(action)];
    
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [throttleData setObject:[NSDate date] forKey:NSStringFromSelector(action)];
        __weak typeof(self) weakSelf = self;
        [weakSelf performSelector:action withObject:object1 withObject:object2];
    }
}

- (void)debounceWithSelector:(nonnull SEL)action withObject:(nullable id)object duration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:action object:object];
    [weakSelf performSelector:action withObject:object afterDelay:duration];
}

- (void)debounceWithBlock:(void (^)(void))block duration:(NSTimeInterval)duration{
    if(![self isRateLimitingWithDuration:duration]){
        SEL action=@selector(debounceWithBlock:);
        __weak typeof(self) weakSelf = self;
        [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:action object:block];
        [weakSelf performSelector:action withObject:block afterDelay:duration];
    }
}


-(void)debounceWithBlock:(void (^)(void))block{
    block();
}


- (BOOL)isRateLimitingWithDuration:(NSTimeInterval)duration{
    NSMutableDictionary *throttleData = [self getThrottleData];
    NSString *key=@"____lastRateLimitingTime";
    NSDate *lastCalled = [throttleData objectForKey:key];
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [throttleData setObject:[NSDate date] forKey:key];
        return NO;
    }
    return YES;
}

+ (BOOL)isRateLimitingWithId:(NSString *)ids duration:(NSTimeInterval)duration{
    NSMutableDictionary *throttleData = [UIApplication.sharedApplication getThrottleData];
    NSDate *lastCalled = [throttleData objectForKey:ids];
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [throttleData setObject:[NSDate date] forKey:ids];
        return NO;
    }
    return YES;
}

@end
