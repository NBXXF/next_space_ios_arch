//
//  SwizzleMethod.m
//  ETicket
//
//  Created by chunjian wang on 2017/12/12.
//  Copyright © 2017年 chunjian wang. All rights reserved.
//

#import "SwizzleMethod.h"
#import <objc/runtime.h>

@implementation SwizzleMethod

+ (void)swizzleMethod:(Class)cls originalSelector:(SEL)originalSel swizzledSelector:(SEL)swizzledSel {
    Class class = cls;
    SEL originalSelector = originalSel;
    SEL swizzledSelector = swizzledSel;

    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
