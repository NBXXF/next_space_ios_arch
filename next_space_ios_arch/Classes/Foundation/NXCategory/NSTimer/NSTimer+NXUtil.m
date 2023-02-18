//
//  NSTimer+NXUtil.m
//  NX
//
//  Created by hedeyong on 2017/2/15.
//  Copyright © 2017年 NextSpace. All rights reserved.
//
// 使用重复的定时器，防止忘记invalidate 产生循环引用

#import "NSTimer+NXUtil.h"

@implementation NSTimer (NXUtil)

+ (NSTimer *)nx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(nx_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (NSTimer *)nx_timerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats
{
    return [self timerWithTimeInterval:interval
                                target:self
                              selector:@selector(nx_blockInvoke:)
                              userInfo:[block copy]
                               repeats:repeats];
}

+ (void)nx_blockInvoke:(NSTimer*)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
