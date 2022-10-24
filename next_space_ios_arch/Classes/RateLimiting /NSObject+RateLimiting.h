//
//  NSObject+RateLimiting.h
//  JLRoutes
//  时间维度节流或者防暴力点击工具
//  Created by XXF on 2022/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(RateLimiting)

- (void)throttleWithSelector:(nonnull SEL)action
                  withObject:(nullable id)object
                    duration:(NSTimeInterval)duration;

- (void)throttleWithSelector:(nonnull SEL)action
                  withObject:(nullable id)object1
                  withObject:(nullable id)object2
                    duration:(NSTimeInterval)duration;

- (void)debounceWithSelector:(nonnull SEL)action
                  withObject:(nullable id)object duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
