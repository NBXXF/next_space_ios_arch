//
//  RACSignal+AppArch.m
//  AppArch
//
//  Created by XXF on 2022/9/8.
//

#import "RACSignal+AppArch.h"

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


- (RACSignal *)deliverOnOnSubThread{
    return [self deliverOn:RACScheduler.scheduler];
}


- (RACSignal *)distinctUntilChangedWithBlock:(BOOL (^)(id last,id current))block{
    Class class = self.class;

    return [[self bind:^{
        __block id lastValue = nil;
        __block BOOL initial = YES;

        return ^(id x, BOOL *stop) {
            if (!initial && (block(lastValue,x))) return [class empty];

            initial = NO;
            lastValue = x;
            return [class return:x];
        };
    }] setNameWithFormat:@"[%@] -distinctUntilChanged", self.name];
}

@end
