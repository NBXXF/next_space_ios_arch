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

- (void)throttle:(nonnull SEL)action withObject:(nullable id)object duration:(NSTimeInterval)duration {
    NSMutableDictionary *throttleData = [self getThrottleData];

    NSDate *lastCalled = [throttleData objectForKey:NSStringFromSelector(action)];
    
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [throttleData setObject:[NSDate date] forKey:NSStringFromSelector(action)];
        __weak typeof(self) weakSelf = self;
        [weakSelf performSelector:action withObject:object];
    }
}

- (void)debounce:(nonnull SEL)action withObject:(nullable id)object duration:(NSTimeInterval)duration {
    __weak typeof(self) weakSelf = self;
    [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:action object:object];
    [weakSelf performSelector:action withObject:object afterDelay:duration];
}

@end
