//
//  RACSignal+AppArch.m
//  AppArch
//
//  Created by XXF on 2022/9/8.
//

#import "RACSignal+AppArch.h"
typedef BOOL (^DistinctUntilChangedWithBlock)(id last,id current);
@implementation RACSignal(AppArch)

- (RACSignal *)subscribe{
    return [self subscribeNext:^(id  _Nullable x) {
        
    }];
}

+ (RACSignal *)just:(id __nullable)value{
    return [RACSignal return:value];
}

+ (RACSignal *)fromCallbck:(id __nullable (^)(void))block{
    return [RACSignal defer:^RACSignal * _Nonnull{
        return [RACSignal return:block()];
    }];
}

- (RACSignal *)onErrorReturnItem:(id)value{
    return [self catchTo:[RACSignal just:value]];
}

- (RACSignal *)onErrorReturn:(id  _Nullable (^)(void))block{
    return [self catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
        return [RACSignal just:block()];
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

@end
