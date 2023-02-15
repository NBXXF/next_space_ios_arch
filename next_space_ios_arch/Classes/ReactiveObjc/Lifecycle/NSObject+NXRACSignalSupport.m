//
//  NSObject+NXRACSignalSupport.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import "NSObject+NXRACSignalSupport.h"
#import <objc/runtime.h>

@implementation NSObject(NXRACSignalSupport)

- (RACSignal<RACUnit *> *)untilDeallocSignal{
    return [self rac_willDeallocSignal];
}

- (RACSignal<RACUnit *> *)untilUniqueSignalWithOwner:(NSObject *)lifecycleOwner identifier:(NSString *)identifier{
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if (signal != nil) return signal;

    RACReplaySubject *subject = [RACReplaySubject subject];

    [self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
        [subject sendCompleted];
    }]];

    objc_setAssociatedObject(self, _cmd, subject, OBJC_ASSOCIATION_RETAIN);

    return subject;
}

- (RACSignal<RACUnit *> *)untilUniqueOrDeallocSignalWithOwner:(NSObject *)lifecycleOwner identifier:(NSString *)identifier{
    return [self.untilDeallocSignal merge:[self untilUniqueSignalWithOwner:lifecycleOwner identifier:identifier]];
}
@end
