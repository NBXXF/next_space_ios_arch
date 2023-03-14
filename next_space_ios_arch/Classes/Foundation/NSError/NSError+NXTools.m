//
//  NSError+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/12.
//

#import "NSError+NXTools.h"
#import <next_space_ios_arch/NSMutableDictionary+NXTools.h>

@implementation NSError(NXTools)

+ (NSError *)nx_ErrorWithErrorOrException:(NSObject *)errorOrException{
    if([errorOrException isKindOfClass:NSError.class]){
        return (NSError *)errorOrException;
    }else if([errorOrException isKindOfClass:NSException.class]){
        return [self nx_convertException:(NSException *)errorOrException];
    }
    return nil;
}

+ (NSError *)nx_ErrorWithCode:(NSInteger)code text:(NSString *)text {
    return [NSError errorWithDomain:@"com.next.space.cflow" code:code userInfo:@{NSLocalizedDescriptionKey:text ?: @""}];
}

+ (NSError *)nx_ErrorWithError:(NSError *)error userInfo:(NSDictionary *)userInfo{
    NSMutableDictionary *merge=[NSMutableDictionary dictionary];
    if(userInfo){
        [merge addEntriesFromDictionary:userInfo];
    }
    if(error.userInfo){
        [merge addEntriesFromDictionary:error.userInfo];
    }
    return [NSError errorWithDomain:error.domain code:error.code userInfo:merge];
}

+ (NSError *)nx_convertException:(NSException *)exception {
    NSMutableDictionary * info = [exception.userInfo mutableCopy];
    if(!info){
        info=[NSMutableDictionary dictionary];
    }
    [info putCheck:@"ExceptionName" forObject:exception.name];
    [info putCheck:@"ExceptionReason" forObject:exception.reason];
    /**
     这两个耗时严重 注释掉
     */
//    [info putCheck:@"ExceptionCallStackReturnAddresses" forObject:exception.callStackReturnAddresses];
//    [info putCheck:@"ExceptionCallStackSymbols" forObject:exception.callStackSymbols];
    [info putCheck:@"ExceptionUserInfo" forObject:exception.userInfo];
    //增加兼容
    [info putCheck:NSLocalizedDescriptionKey forObject:exception.reason?:exception.name];
    
   return [[NSError alloc] initWithDomain:@"com.next.space.cflow" code:-1 userInfo:info];
}
@end
