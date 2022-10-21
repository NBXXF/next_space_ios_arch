
//
//  NSObject+ExchangeMethod
//  Pods
//  交换方法
//  Created by XXF on 2022/9/30.
//
#import <Foundation/Foundation.h>

@interface NSObject (ExchangeMethod)
+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;
@end
