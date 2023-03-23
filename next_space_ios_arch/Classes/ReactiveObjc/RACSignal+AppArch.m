//
//  RACSignal+AppArch.m
//  AppArch
//
//  Created by XXF on 2022/9/8.
//

#import "RACSignal+AppArch.h"
typedef BOOL (^DistinctUntilChangedWithBlock)(id last,id current);
typedef id __nullable (^ResultCallbck)(void);
@implementation RACSignal(AppArch)

- (RACSignal *)subscribe{
    return [self subscribeNext:^(id  _Nullable x) {
        
    }];
}

+ (RACSignal *)just:(id __nullable)value{
    return [RACSignal return:value];
}

+ (RACSignal *)fromCallbck:(id __nullable (^)(void))block{
    __block ResultCallbck fromCallBack=block;
    return [RACSignal defer:^RACSignal * _Nonnull{
        return [RACSignal return:fromCallBack()];
    }];
}

- (RACSignal *)onErrorReturnItem:(id)value{
    return [self catchTo:[RACSignal just:value]];
}

- (RACSignal *)onErrorReturn:(id  _Nullable (^)(void))block{
    __block ResultCallbck errorCallBack=block;
    return [self catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
        return [RACSignal just:errorCallBack()];
    }];
}

- (RACSignal *)onErrorResumeNext:(RACSignal * _Nonnull (^)(NSError * _Nonnull))catchBlock{
    return [self catch:catchBlock];
}

- (RACSignal *)concatIgnoreError:(RACSignal *)signal {
    return [[[self ignoreError] concat:signal]
            setNameWithFormat:@"[%@] -then:", self.name];
}

- (RACSignal *)ignoreError {
    return [self catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
        return [RACSignal return:nil];
    }];
}


- (RACSignal *)subscribeOnSubThread{
    return [self subscribeOn:RACScheduler.scheduler];
}

- (RACSignal *)subscribeOnSubThread:(BOOL)inheritContext{
    if(inheritContext){
        BOOL isSubThread=![NSThread isMainThread];
        if(isSubThread){
            return [self subscribeOn:RACScheduler.immediateScheduler];
        }
    }
    return [self subscribeOn:RACScheduler.scheduler];
}


- (RACSignal *)deliverOnOnSubThread{
    return [self deliverOn:RACScheduler.scheduler];
}

- (RACSignal *)deliverOnOnSubThread:(BOOL)inheritContext{
    if(inheritContext){
        BOOL isSubThread=![NSThread isMainThread];
        if(isSubThread){
            return [self deliverOn:RACScheduler.immediateScheduler];
        }
    }
    return [self deliverOn:RACScheduler.scheduler];
}


- (RACSignal *)distinctUntilChangedWithBlock:(BOOL (^)(id last,id current))block{
    Class class = self.class;

    return [[self bind:^{
        __block id lastValue = nil;
        __block BOOL initial = YES;
        //先强制持有
        __block DistinctUntilChangedWithBlock callback=block;

        return ^(id x, BOOL *stop) {
            if(callback){
                //这里代码为自定义
                if (!initial && (callback(lastValue,x))) return [class empty];
                
                initial = NO;
                lastValue = x;
                return [class return:x];
            }else{
                //这里代码等同copy from distinctUntilChanged
                if (!initial && (lastValue == x || [x isEqual:lastValue])) return [class empty];

                initial = NO;
                lastValue = x;
                return [class return:x];
            }
        };
    }] setNameWithFormat:@"[%@] -distinctUntilChangedWithBlock", self.name];
}


- (RACSignal *)doSubscribe:(void (^)(void))block{
    NSCParameterAssert(block != NULL);
    return [[RACSignal defer:^{
        block();
        return self;
    }] setNameWithFormat:@"[%@] -doSubscribe:", self.name];
}


- (RACSignal *)bindLifecycle:(RACSignal<RACUnit *> *)untilSignal{
    NSCParameterAssert(untilSignal);
    if(untilSignal){
        return [self takeUntil:untilSignal];
    }else{
        return self;
    }
}

/**
 绑定生命周期到对象销毁
 */
- (RACSignal *)bindLifecycleWithOwner:(NSObject *)lifecycleOwner  DEPRECATED_MSG_ATTRIBUTE("过时了 请直接使用#bindLifecycle方法"){
    if(!lifecycleOwner){
        NSAssert(NO, @"lifecycleOwner参数错误");
    }else{
        return [self takeUntil:lifecycleOwner.rac_willDeallocSignal];
    }
    return self;
}


/**
 检查每个流节点的耗时问题,仅仅在debug生效,不会影响线上
 场景 主线程也卡不住,cpu也有富裕,那么每个流节点耗时太长,转圈圈太多的情况,
 需要手动去排查,还要做时间剪法,比较糟糕,那么可以选择每个节点去去加一个timeoutOnlyDebug
 */
- (RACSignal *)timeoutOnlyDebug:(NSTimeInterval)interval{
#if DEBUG
    BOOL isSubThread=![NSThread isMainThread];
    if(isSubThread){
        return [[self timeout:interval onScheduler:RACScheduler.currentScheduler] doError:^(NSError * _Nonnull error) {
            //timeout操作符号发送的[NSError errorWithDomain:RACSignalErrorDomain code:RACSignalErrorTimedOut userInfo:nil]
            if(error.code==RACSignalErrorTimedOut&&[error.domain isEqual:RACSignalErrorDomain]){
                NSAssert(NO, @"该流节点超时了,请查看xcode 侧边栏排查");
            }
        }];
    }
    return [[self timeout:interval onScheduler:RACScheduler.scheduler] doError:^(NSError * _Nonnull error) {
        //timeout操作符号发送的[NSError errorWithDomain:RACSignalErrorDomain code:RACSignalErrorTimedOut userInfo:nil]
        if(error.code==RACSignalErrorTimedOut&&[error.domain isEqual:RACSignalErrorDomain]){
            NSAssert(NO, @"该流节点超时了,请查看xcode 侧边栏排查");
        }
    }];
#else
    return self;
#endif
}
@end
