//
//  RACScheduler+AppArch.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACScheduler(AppArch)

/**
 延迟任务,支持取消
 其他线程 可以参考RACScheduler成员方法
 [[RACScheduler xxxScheduler] afterDelay:1 schedule:^{
 <#code#>
 }]
 */
+ (nullable RACDisposable *)afterInMainThreadScheduler:(NSDate *)date schedule:(void (^)(void))block;


/**
 延迟发送,支持取消
 其他线程 可以参考RACScheduler成员方法
 [[RACScheduler xxxScheduler] afterDelay:1 schedule:^{
 <#code#>
 }]
 */
+ (nullable RACDisposable *)afterDelayInMainThreadScheduler:(NSTimeInterval)delay schedule:(void (^)(void))block;


/**
 延迟任务 支持重试，支持取消
 其他线程 可以参考RACScheduler成员方法
 [[RACScheduler xxxScheduler] afterDelay:1 schedule:^{
 <#code#>
 }]
 */
+ (nullable RACDisposable *)afterInMainThreadScheduler:(NSDate *)date repeatingEvery:(NSTimeInterval)interval withLeeway:(NSTimeInterval)leeway schedule:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
