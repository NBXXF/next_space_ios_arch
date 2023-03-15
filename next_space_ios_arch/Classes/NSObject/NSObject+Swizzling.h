//
//  NSObject+Swizzling.h
//  SafeObjectCrash
//
//  Created by lujh on 2018/4/18.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)exchangeInstanceMethodWithSelfClass:(Class)cls
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector DEPRECATED_MSG_ATTRIBUTE("请使用nx_swizzleInstanceMethodWithClass");

+ (void)nx_swizzleInstanceMethodWithClass:(Class)cls
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;

+ (void)nx_swizzleClassMethodWithClass:(Class)cls
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;
@end
