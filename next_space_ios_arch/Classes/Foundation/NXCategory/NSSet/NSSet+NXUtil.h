//
//  NSMutableSet+NXUtil.h
//  NX
//
//  Created by hedeyong on 2021/06/20.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSSet (NXUtil)

/*!
 @method isEmpty:
 @abstract 是否没有对象，没有对象也是为YES；
 @param object 验证对象
 @result 返回BOOL
 */
+ (BOOL)isEmpty:(NSSet *)object;

/*!
 @method isEmpty
 @abstract 是否没有对象，没有对象也是为YES；
 @result 返回BOOL
 */
- (BOOL)isEmpty;

@end


@interface NSMutableSet (NXUtil)

/*!
 @method addObjects:
 @abstract 把多个对象添加到数组里
 @param objects 要添加对象
 */
- (void)addObjects:(id)objects, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 @method addObjectCheck:
 @abstract 检查对象是不是为 nil ;不是则添加
 @param anObject 要添加对象
 */
- (void)addObjectCheck:(id)anObject;

/*!
 @method addChar:
 @abstract 添加char类型值，到数组里
 @param value 值
 */
- (void)addChar:(char)value;

/*!
 @method addUnsignedChar:
 @abstract 添加unsigned char类型值，到数组里
 @param value 值
 */
- (void)addUnsignedChar:(unsigned char)value;

/*!
 @method addShort:
 @abstract 添加short类型值，到数组里
 @param value 值
 */
- (void)addShort:(short)value;

/*!
 @method addUnsignedShort:
 @abstract 添加unsigned short类型值，到数组里
 @param value 值
 */
- (void)addUnsignedShort:(unsigned short)value;

/*!
 @method addInt:
 @abstract 添加int类型值，到数组里
 @param value 值
 */
- (void)addInt:(int)value;

/*!
 @method addUnsignedInt:
 @abstract 添加unsigned int类型值，到数组里
 @param value 值
 */
- (void)addUnsignedInt:(unsigned int)value;

/*!
 @method addLong:
 @abstract 添加long类型值，到数组里
 @param value 值
 */
- (void)addLong:(long)value;

/*!
 @method addUnsignedLong:
 @abstract 添加unsigned long类型值，到数组里
 @param value 值
 */
- (void)addUnsignedLong:(unsigned long)value;

/*!
 @method addLongLong:
 @abstract 添加long long类型值，到数组里
 @param value 值
 */
- (void)addLongLong:(long long)value;

/*!
 @method addUnsignedLongLong:
 @abstract 添加unsigned long long类型值，到数组里
 @param value 值
 */
- (void)addUnsignedLongLong:(unsigned long long)value;

/*!
 @method addFloat:
 @abstract 添加float类型值，到数组里
 @param value 值
 */
- (void)addFloat:(float)value;

/*!
 @method addDouble:
 @abstract 添加double类型值，到数组里
 @param value 值
 */
- (void)addDouble:(double)value;

/*!
 @method addBool:
 @abstract 添加BOOL类型值，到数组里
 @param value 值
 */
- (void)addBool:(BOOL)value;

/*!
 @method addInteger:
 @abstract 添加NSInteger类型值，到数组里
 @param value 值
 */
- (void)addInteger:(NSInteger)value;

/*!
 @method addUnsignedInteger:
 @abstract 添加NSUInteger类型值，到数组里
 @param value 值
 */
- (void)addUnsignedInteger:(NSUInteger)value;

/*!
 @method addPointValue:
 @abstract 添加CGPoint类型值，到数组里
 @param value 值
 */
- (void)addPointValue:(CGPoint)value;

/*!
 @method addSizeValue:
 @abstract 添加CGSize类型值，到数组里
 @param value 值
 */
- (void)addSizeValue:(CGSize)value;

/*!
 @method addRectValue:
 @abstract 添加CGRect类型值，到数组里
 @param value 值
 */
- (void)addRectValue:(CGRect)value;

@end
