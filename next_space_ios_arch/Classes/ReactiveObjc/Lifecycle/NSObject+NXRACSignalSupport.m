//
//  NSObject+NXRACSignalSupport.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import "NSObject+NXRACSignalSupport.h"
#import <objc/runtime.h>
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation NSObject(NXRACSignalSupport)

- (RACSignal<RACUnit *> *)untilDeallocSignal{
    return [self rac_willDeallocSignal];
}
- (RACSignal<RACUnit *> * _Nonnull (^)(NSString * _Nonnull))untilUniqueSignalWithIdentifier{
    return ^RACSignal<RACUnit *> *(NSString * _Nonnull identifier){
        NSAssert(identifier, @"identifier 必须不为空");
        NSMutableDictionary *uniqueSubjectDict=[NSMutableDictionary toKindOfClassObjectOrNilFrom:objc_getAssociatedObject(self, _cmd)]?:[NSMutableDictionary dictionary];
        
        RACReplaySubject *signal = uniqueSubjectDict[identifier];
        if (signal){
            //就是要主动取消上次的 避免重复绑定
            [signal sendCompleted];
        }
      
        RACReplaySubject *subject = [RACReplaySubject subject];
        [uniqueSubjectDict setObject:subject forKey:identifier];
        
        objc_setAssociatedObject(self, _cmd, uniqueSubjectDict, OBJC_ASSOCIATION_RETAIN);
        return subject;
    };
}

- (RACSignal<RACUnit *> * _Nonnull (^)(NSString * _Nonnull))untilUniqueOrDeallocSignalWithIdentifier{
    return ^RACSignal<RACUnit *> *(NSString * _Nonnull identifier){
        return [self.untilDeallocSignal merge:self.untilUniqueSignalWithIdentifier(identifier)];
    };
}

@end
