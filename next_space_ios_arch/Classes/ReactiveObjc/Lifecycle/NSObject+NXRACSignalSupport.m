//
//  NSObject+NXRACSignalSupport.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import "NSObject+NXRACSignalSupport.h"
#import <objc/runtime.h>
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <next_space_ios_arch/NSArray+AppArch.h>
#import <next_space_ios_arch/XXF.h>

@implementation NSObject(NXRACSignalSupport)

- (RACSignal<RACUnit *> *)untilDeallocSignal{
    return [self rac_willDeallocSignal];
}
- (RACSignal<RACUnit *> * _Nonnull (^)(NSString * _Nonnull))untilUniqueSignalWithIdentifier{
    return ^RACSignal<RACUnit *> *(NSString * _Nonnull identifier){
        NSAssert(identifier, @"identifier 必须不为空");
        NSMutableDictionary *uniqueSubjectDict=[NSMutableDictionary toKindOfClassObjectOrNilFrom:objc_getAssociatedObject(self, _cmd)]?:[NSMutableDictionary dictionary];
        
        RACReplaySubject *signal = [RACReplaySubject toKindOfClassObjectOrNilFrom:[uniqueSubjectDict objectForKey:identifier]];
        if (signal){
            //就是要主动取消上次的 避免重复绑定
            [signal sendCompleted];
        }
        
        RACReplaySubject *subject = [RACReplaySubject subject];
        [uniqueSubjectDict setObject:subject forKey:identifier];
        
        objc_setAssociatedObject(self, _cmd, uniqueSubjectDict, OBJC_ASSOCIATION_RETAIN);
        
        
#if DEBUG
        [self ____checkDebugSignalWithIdentifier:identifier];
        NSAssert(uniqueSubjectDict.count<=10, @"违规监听了,一个类哪有这么多监听");
#endif
        return subject;
    };
}

-(void)____checkDebugSignalWithIdentifier:(NSString *)identifier{
#if DEBUG
    if(XXF.shared.config.allowCallStackSymbols){
        NSMutableDictionary *callStackDict=[NSMutableDictionary toKindOfClassObjectOrNilFrom:objc_getAssociatedObject(self, _cmd)]?:[NSMutableDictionary dictionary];
        NSString *lastUserCallLine=[callStackDict objectForKey:identifier];

        NSArray<NSString *> *callStack = [NSThread callStackSymbols];
        //ios内核得不到+[ 或者-[
        NSString *prefixCallInstanceMethod=@"-[";
        NSString *prefixCallStaticMethod=@"+[";
        NSString *userCallLine = [callStack firstObjectWithBlock:^BOOL(NSString * _Nonnull obj) {
            //注意这两个内置方法
            if([obj containsString:@"____checkDebugSignalWithIdentifier"]
               ||[obj containsString:@"untilUniqueSignalWithIdentifier"]
               ||[obj containsString:@"untilUniqueOrDeallocSignalWithIdentifier"]){
                return NO;
            }

            if([obj containsString:prefixCallInstanceMethod]||[obj containsString:prefixCallStaticMethod]){
                return YES;
            }
            return NO;
        }];
        NSRange range=[userCallLine rangeOfString:prefixCallInstanceMethod];
        if(range.length==0){
            range=[userCallLine rangeOfString:prefixCallStaticMethod];
        }
        if(range.length!=0){
            userCallLine=[userCallLine substringFromIndex:range.location];
        }


        if(lastUserCallLine&&![lastUserCallLine isEqual:userCallLine]){
            NSString *errorDesc = [NSString stringWithFormat:@"绑定生命周期在同不同位置添加了一样的唯一标识%@",identifier];
            NSAssert(NO, errorDesc);
        }
        if(userCallLine){
            [callStackDict setObject:userCallLine forKey:identifier];
            objc_setAssociatedObject(self, _cmd, callStackDict, OBJC_ASSOCIATION_RETAIN);
        }

        NSString *callStackString = [NSString stringWithFormat:@"%@",callStackDict];
        NSLog(@"======>untilUniqueIdentifier_%@_adding(%@)  all:%@",self.simpleDescription,identifier,callStackString);
    }
#endif
}

- (RACSignal<RACUnit *> * _Nonnull (^)(NSString * _Nonnull))untilUniqueOrDeallocSignalWithIdentifier{
    return ^RACSignal<RACUnit *> *(NSString * _Nonnull identifier){
        return [self.untilDeallocSignal merge:self.untilUniqueSignalWithIdentifier(identifier)];
    };
}

@end
