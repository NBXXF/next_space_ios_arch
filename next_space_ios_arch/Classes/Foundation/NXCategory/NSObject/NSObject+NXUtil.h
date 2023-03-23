//
//  NSObject+NXUtil.h
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (NXUtil)

/*!
 @method performSelector:array:
 @abstract performSelector 扩展
 @param aSelector selector
 @param objects NSArray类型参数指针
 @result 返回调用的值类型为id
 */
- (id)performSelector:(SEL)aSelector array:(NSArray *)objects;

/*!
 @method performSelector:parameters:
 @abstract performSelector 扩展
 @param aSelector selector
 @param parameters 参数指针
 @result 返回调用的值类型为id
 */
- (id)performSelector:(SEL)aSelector parameters:(void *)parameters, ...;

/*!
 @method performSelector:afterDelay:parameters:
 @abstract performSelector 扩展
 @param aSelector selector
 @param delay 延时执行
 @param parameters NSObject类型参数指针，这里不能用void *，因为非NSObject局部变量不能retain
 */
- (void)performSelector:(SEL)aSelector afterDelay:(NSTimeInterval)delay parameters:(NSObject *)parameters, ...;

@end

