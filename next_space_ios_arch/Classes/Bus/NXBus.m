//
//  NXBus.m
//  ios_oc_reactiveCocoa
//
//  Created by XXF on 2021/8/3.
//

#import "NXBus.h"

static RACSubject *subject;
@implementation NXBus

+ (RACSignal *)subscribeEvent:(Class)t{
    if(!subject){
        subject = [RACSubject subject];
    }
    return [subject filter:^BOOL(id  _Nullable value) {
        return [value isKindOfClass:t] || [value isMemberOfClass:t];
    }];
}

+ (void)postEvent:(id)event{
    if(!subject){
        subject = [RACSubject subject];
    }
    if(event!=nil){
        [subject sendNext:event];
    }
}
@end
