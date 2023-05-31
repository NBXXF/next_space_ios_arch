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
 @param inheritContext 代表是否继承上文的子线程  如果上文是子线程 那么还是在那个子线程
 */
+ (RACScheduler *)scheduler:(BOOL)inheritContext;

/**
 延迟任务,支持取消
 其他线程 可以参考RACScheduler成员方法
 [[RACScheduler xxxScheduler] afterDelay:1 schedule:^{
 <#code#>
 }]
 
 如果需求延迟和回调不一致的线程 那么可以选择
 [[[[[RACSignal just:@""] delay:1.0]subscribeOn:RACScheduler.scheduler] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id  _Nullable x) {
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
 
 如果需求延迟和回调不一致的线程 那么可以选择
 [[[[[RACSignal just:@""] delay:1.0]subscribeOn:RACScheduler.scheduler] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id  _Nullable x) {
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
 
 如果需求延迟和回调不一致的线程 那么可以选择
 [[[[[RACSignal just:@""] delay:1.0]subscribeOn:RACScheduler.scheduler] deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(id  _Nullable x) {
     <#code#>
 }]
 */
+ (nullable RACDisposable *)afterInMainThreadScheduler:(NSDate *)date repeatingEvery:(NSTimeInterval)interval withLeeway:(NSTimeInterval)leeway schedule:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
