//
//  NSError+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/12.
//

#import "NSError+NXTools.h"

@implementation NSError(NXTools)

+ (NSError *)nx_ErrorWithCode:(NSInteger)code text:(NSString *)text {
    return [NSError errorWithDomain:@"com.next.space.cflow" code:code userInfo:@{NSLocalizedDescriptionKey:text ?: @""}];
}

+ (NSError *)nx_convertException:(NSException *)exception {
    NSMutableDictionary * info = [exception.userInfo mutableCopy];
    if(!info){
        info=[NSMutableDictionary dictionary];
    }
   [info setValue:exception.name forKey:@"ExceptionName"];
   [info setValue:exception.reason forKey:@"ExceptionReason"];
   [info setValue:exception.callStackReturnAddresses forKey:@"ExceptionCallStackReturnAddresses"];
   [info setValue:exception.callStackSymbols forKey:@"ExceptionCallStackSymbols"];
   [info setValue:exception.userInfo forKey:@"ExceptionUserInfo"];
    
    //增加兼容
   [info setValue:exception.reason?:exception.name forKey:NSLocalizedDescriptionKey];
   return [[NSError alloc] initWithDomain:@"com.next.space.cflow" code:-1 userInfo:info];
}
@end
