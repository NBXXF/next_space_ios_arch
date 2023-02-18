//
//  NSTimer+NXUtil.h
//  NX
//
//  Created by hedeyong on 2017/2/15.
//  Copyright © 2017年 NextSpace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (NXUtil)
+ (NSTimer *)nx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;

+ (NSTimer *)nx_timerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;

@end

