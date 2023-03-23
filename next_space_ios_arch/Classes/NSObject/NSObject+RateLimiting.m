//
//  NSObject+RateLimiting.m
//  JLRoutes
//  时间维度节流或者防暴力点击工具
//  Created by XXF on 2022/10/24.
//

#import "NSObject+RateLimiting.h"
#import <next_space_ios_arch/NSObject+NXAssociation.h>
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation NSObject (RateLimiting)

- (void)throttleWithBlock:(void (^)(void))block duration:(NSTimeInterval)duration{
    if(![self isRateLimitingWithDuration:duration]){
        block();
    }
}


- (void)throttleWithSelector:(nonnull SEL)action withObject:(nullable id)object duration:(NSTimeInterval)duration {
    NSString *key=[NSString stringWithFormat:@"%@_%@",__FILE_LINE__,NSStringFromSelector(action)];
    NSDate *lastCalled = [self getObjcAssociatedObject:key];
    
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [self setObjcAssociatedObject:[NSDate date] forKey:key];
        __weak typeof(self) weakSelf = self;
        [weakSelf performSelector:action withObject:object];
    }
}


- (void)throttleWithSelector:(SEL)action withObject:(id)object1 withObject:(id)object2 duration:(NSTimeInterval)duration{
    NSString *key=[NSString stringWithFormat:@"%@_%@",__FILE_LINE__,NSStringFromSelector(action)];
    NSDate *lastCalled = [self getObjcAssociatedObject:key];
    
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [self setObjcAssociatedObject:[NSDate date] forKey:key];
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
    NSString *key=[NSString stringWithFormat:@"%@_%@",__FILE_LINE__,NSStringFromSelector(_cmd)];
    NSDate *lastCalled = [self getObjcAssociatedObject:key];
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [self setObjcAssociatedObject:[NSDate date] forKey:key];
        return NO;
    }
    return YES;
}

+ (BOOL)isRateLimitingWithId:(NSString *)ids duration:(NSTimeInterval)duration{
    NSString *key=ids;
    NSDate *lastCalled = [UIApplication.sharedApplication getObjcAssociatedObject:key];
    if(!lastCalled || ([[NSDate date] timeIntervalSinceDate:lastCalled]) >= duration) {
        [UIApplication.sharedApplication setObjcAssociatedObject:[NSDate date] forKey:key];
        return NO;
    }
    return YES;
}

@end
