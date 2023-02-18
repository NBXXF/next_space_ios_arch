//
//  NSObject+NXUtil.m
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import "NSObject+NXUtil.h"
#import <objc/runtime.h>
#import "NSDictionary+NXUtil.h"

@implementation NSObject (NXUtil)

+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError * __autoreleasing *)error
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    if (!originalMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(originalSelector)];
        *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(swizzledSelector)];
        *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    return YES;
}

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




- (void)setAssociatedObject:(id)key value:(id)value
{
    if (key == nil || value == nil) {
        return;
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getAssociatedObject:(id)key
{
    if (key == nil) {
        return nil;
    }
    
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

- (void)removeAssociatedObject:(id)key
{
    if (key == nil) {
        return;
    }
    
    objc_setAssociatedObject(self, (__bridge const void *)(key), nil, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)associatedObjectExists:(id)key
{
    return [self getAssociatedObject:key] == nil ? NO : YES;
}

- (void)removeAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}


//自己定义释放对象的关联
- (NSMutableDictionary *)destoryNotifyDictionary
{
    NSString *key = @"kDestoryNotifyDictionary";
    NSMutableDictionary *dictionary = [self getAssociatedObject:key];
    if (dictionary == nil) {
        dictionary = [NSMutableDictionary dictionary];
        [self setAssociatedObject:key value:dictionary];
    }
    return dictionary;
}

//iOS8 是有问题
- (void)destoryNotifyAddName:(NSString *)name block:(NXDestoryNotifyBlock)block
{
    [self destoryNotifyAddName:name userInfo:nil block:block];
}

- (void)destoryNotifyAddName:(NSString *)name userInfo:(NSDictionary *)userInfo block:(NXDestoryNotifyBlock)block
{
    [self destoryNotifyRemoveWithName:name];
    
    NXDestoryNotify *notify = [[NXDestoryNotify alloc] init];
    notify.name = name;
    notify.block = block;
    notify.userInfo = userInfo;
    [[self destoryNotifyDictionary] nx_setObjectCheck:notify forKey:name];
}

- (void)destoryNotifyRemoveWithName:(NSString *)name
{
    NSMutableDictionary *dictionary = [self destoryNotifyDictionary];
    NXDestoryNotify *notify = [dictionary nx_objectForKeyCheck:name];
    if (notify != nil) {
        notify.block = nil;
        notify.userInfo = nil;
        [dictionary nx_removeObjectForKeyCheck:name];
        notify = nil;
    }
}

@end


@implementation NXDestoryNotify

- (void)dealloc
{
    NXDestoryNotifyBlock block = [self block];
    if (block != nil) {
        block(self);
    }
    
    _block = nil;
    _userInfo = nil;
    _name = nil;
}

@end
