//
//  NSObject+Swizzling.m
//  SafeObjectCrash
//
//  Created by lujh on 2018/4/18.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSObject (Swizzling)
+ (void)exchangeInstanceMethodWithSelfClass:(Class)cls
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    
    return [self nx_swizzleInstanceMethodWithClass:cls
                                  originalSelector:originalSelector
                                  swizzledSelector:swizzledSelector];
}



+ (void)nx_swizzleInstanceMethodWithClass:(Class)cls
                         originalSelector:(SEL)originalSelector
                         swizzledSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    BOOL didAddMethod = class_addMethod(cls,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)nx_swizzleClassMethodWithClass:(Class)cls
                      originalSelector:(SEL)originalSelector
                      swizzledSelector:(SEL)swizzledSelector{
    if (!cls) {
        return;
    }
    Method originalMethod = class_getClassMethod(cls, originalSelector);
    Method swizzledMethod = class_getClassMethod(cls, swizzledSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod(metacls,
                            swizzledSelector,
                            class_replaceMethod(metacls,
                                                originalSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

@end
