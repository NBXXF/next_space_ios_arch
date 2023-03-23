//
//  NSObject+NXUtil.m
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import "NSObject+NXUtil.h"

@implementation NSObject (NXUtil)

- (id)performSelector:(SEL)aSelector array:(NSArray *)objects
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    for (id object in objects) {
        __unsafe_unretained id unsafeObject = object;
        [invocation setArgument:&unsafeObject atIndex:++i];
    }
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        void *result = nil;
        [invocation getReturnValue:&result];
        return (__bridge id)result;
    }
    return nil;
}

- (id)performSelector:(SEL)aSelector parameters:(void *)parameters, ...
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSUInteger length = [signature numberOfArguments];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    [invocation setArgument:&parameters atIndex:2];
    va_list arg_ptr;
    va_start(arg_ptr, parameters);
    for (NSUInteger i = 3; i < length; ++i) {
        void *parameter = va_arg(arg_ptr, void *);
        [invocation setArgument:&parameter atIndex:i];
    }
    va_end(arg_ptr);
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        void *result = nil;
        [invocation getReturnValue:&result];
        return (__bridge id)result;
    }
    return nil;
}

- (void)performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay parameters:(NSObject *)parameters, ...
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSUInteger length = [signature numberOfArguments];
    
    __unsafe_unretained id unsafeParameters = parameters;
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];

    [invocation setArgument:&unsafeParameters atIndex:2];
    
    va_list arg_ptr;
    va_start(arg_ptr, parameters);
    for (NSUInteger i = 3; i < length; ++i) {
        NSObject *parameter = va_arg(arg_ptr, NSObject *);
        __unsafe_unretained id unsafeParameter = parameter;
        [invocation setArgument:&unsafeParameter atIndex:i];
    }
    va_end(arg_ptr);
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:delay];
}


@end
