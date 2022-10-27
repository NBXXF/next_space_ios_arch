//
//  RACScheduler+AppArch.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import "RACScheduler+AppArch.h"

@implementation RACScheduler(AppArch)

+ (RACDisposable *)afterInMainThreadScheduler:(NSDate *)date schedule:(void (^)(void))block{
    return  [[RACScheduler mainThreadScheduler] after:date schedule:block];
}

+ (RACDisposable *)afterDelayInMainThreadScheduler:(NSTimeInterval)delay schedule:(void (^)(void))block{
    return  [[RACScheduler mainThreadScheduler] afterDelay:delay schedule:block];
}

+ (RACDisposable *)afterInMainThreadScheduler:(NSDate *)date repeatingEvery:(NSTimeInterval)interval withLeeway:(NSTimeInterval)leeway schedule:(void (^)(void))block{
    return  [[RACScheduler mainThreadScheduler] after:date repeatingEvery:interval withLeeway:leeway schedule:block];
}
@end
