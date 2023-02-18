//
//  NSArray+NXUtil.h
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define NX_isEmptyArray(object)         [NSArray      nx_isEmpty:object]

@interface NSArray (NXUtil)

/*!
 @method nx_isEmpty:
 @abstract 是否没有对象，没有对象也是为YES；
 @param object 验证对象
 @result 返回BOOL
 */
+ (BOOL)nx_isEmpty:(NSArray *)object;

/*!
 @method nx_anyObject
 @abstract 获取数组里的一个对象，索引号小的优先返回
 @result 返回数组里的一个对象
 */
- (id)nx_anyObject;

/*!
 @method nx_objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)nx_objectAtIndexCheck:(NSUInteger)index;

/*!
 @method nx_objectAtIndexCheck:class:defaultValue:
 @abstract 获取指定index的对象并检查是否越界和NSNull如果是返回nil
 @param index 索引号
 @param aClass 检查类型
 @result 返回对象
 */
- (id)nx_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass;

/*!
 @method nx_objectAtIndexCheck:class:defaultValue:
 @abstract 获取指定index的对象并检查是否越界和NSNull如果是返回nil,获取失败返回为指定的defaultValue
 @param index 索引号
 @param aClass 检查类型
 @param defaultValue 获取失败要返回的值
 @result 返回对象，获取失败为指定的defaultValue
 */
- (id)nx_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue;

/*!
 @method nx_arrayWithItemsOfClass:
 @abstract 过滤数组，返回所有类型为 aClass 的元素
 @param aClass 用来过滤的类型
 @result 返回符合要求的元素构成的数组，如果没有元素符合要求，返回一个长度为 0 的数组（不是 nil）
 */
- (NSArray *)nx_arrayWithItemsOfClass:(__unsafe_unretained Class)aClass;

/*!
 @method nx_arrayWithItemsOfProtocol:
 @abstract 过滤数组，返回所有类型遵守 Protocol 的元素
 @param aProtocol 用来过滤的类型
 @result 返回符合要求的元素构成的数组，如果没有元素符合要求，返回一个长度为 0 的数组（不是 nil）
 */
- (NSArray *)nx_arrayWithItemsOfProtocol:(Protocol *)aProtocol;

/*!
 @method nx_arrayAtIndex:
 @abstract 获取指定index的NSArray类型值
 @param index 索引号
 @result 返回NSArray，获取失败为nil
 */
- (NSArray *)nx_arrayAtIndex:(NSUInteger)index;

/*!
 @method nx_arrayAtIndex:defaultValue:
 @abstract 获取指定index的NSArray类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSArray，获取失败为指定的defaultValue
 */
- (NSArray *)nx_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;

/*!
 @method nx_mutableArrayAtIndex:
 @abstract 获取指定index的NSMutableArray类型值
 @param index 索引号
 @result 返回NSMutableArray，获取失败为nil
 */
- (NSMutableArray *)nx_mutableArrayAtIndex:(NSUInteger)index;

/*!
 @method nx_mutableArrayAtIndex:defaultValue:
 @abstract 获取指定index的NSMutableArray类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableArray，获取失败为指定的defaultValue
 */
- (NSMutableArray *)nx_mutableArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;

/*!
 @method nx_dictionaryAtIndex:
 @abstract 获取指定index的NSDictionary类型值
 @param index 索引号
 @result 返回NSDictionary，获取失败为nil
 */
- (NSDictionary *)nx_dictionaryAtIndex:(NSUInteger)index;

/*!
 @method nx_dictionaryAtIndex:defaultValue:
 @abstract 获取指定index的NSDictionary类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSDictionary，获取失败为指定的defaultValue
 */
- (NSDictionary *)nx_dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue;

/*!
 @method nx_mutableDictionaryAtIndex:
 @abstract 获取指定index的NSMutableDictionary类型值
 @param index 索引号
 @result 返回NSMutableDictionary，获取失败为nil
 */
- (NSMutableDictionary *)nx_mutableDictionaryAtIndex:(NSUInteger)index;

/*!
 @method nx_mutableDictionaryAtIndex:defaultValue:
 @abstract 获取指定index的NSMutableDictionary类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableDictionary，获取失败为指定的defaultValue
 */
- (NSMutableDictionary *)nx_mutableDictionaryAtIndex:(NSUInteger)index defaultValue:(NSMutableDictionary *)defaultValue;

/*!
 @method nx_dataAtIndex:
 @abstract 获取指定index的NSData类型值
 @param index 索引号
 @result 返回NSData，获取失败为nil
 */
- (NSData *)nx_dataAtIndex:(NSUInteger)index;

/*!
 @method nx_dataAtIndex:defaultValue:
 @abstract 获取指定index的NSData类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSData，获取失败为指定的defaultValue
 */
- (NSData *)nx_dataAtIndex:(NSUInteger)index defaultValue:(NSData *)defaultValue;

/*!
 @method nx_stringAtIndex:
 @abstract 获取指定index的NSString类型值
 @param index 索引号
 @result 返回NSString，获取失败为nil
 */
- (NSString *)nx_stringAtIndex:(NSUInteger)index;

/*!
 @method nx_stringAtIndexToString:
 @abstract 获取指定index的NSString类型值
 @param index 索引号
 @result 返回字NSString，获取失败为@""
 */
- (NSString *)nx_stringAtIndexToString:(NSUInteger)index;

/*!
 @method nx_stringAtIndexToString:defaultValue:
 @abstract 获取指定index的NSString类型值,获取失败返回为指定的defaultValue
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSString，获取失败为指定的defaultValue
 */
- (NSString *)nx_stringAtIndexToString:(NSUInteger)index defaultValue:(NSString *)defaultValue;

/*!
 @method nx_stringAtIndex:defaultValue:
 @abstract 获取指定index的NSString类型值,获取失败返回为指定的defaultValue
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSString，获取失败为指定的defaultValue
 */
- (NSString *)nx_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue;

/*!
 @method nx_numberAtIndex:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @result 返回NSNumber，获取失败为nil
 */
- (NSNumber *)nx_numberAtIndex:(NSUInteger)index;

/*!
 @method nx_numberAtIndex:defaultValue:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSNumber，获取失败为指定的defaultValue
 */
- (NSNumber *)nx_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue;

/*!
 @method nx_charAtIndex:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @result 返回char
 */
- (char)nx_charAtIndex:(NSUInteger)index;

/*!
 @method nx_unsignedCharAtIndex:
 @abstract 获取指定index的unsigned char类型值
 @param index 索引号
 @result 返回unsigned char
 */
- (unsigned char)nx_unsignedCharAtIndex:(NSUInteger)index;

/*!
 @method nx_shortAtIndex:
 @abstract 获取指定index的short类型值
 @param index 索引号
 @result 返回short，获取失败为0
 */
- (short)nx_shortAtIndex:(NSUInteger)index;

/*!
 @method nx_shortAtIndex:defaultValue:
 @abstract 获取指定index的short类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回short，获取失败为指定的defaultValue
 */
- (short)nx_shortAtIndex:(NSUInteger)index defaultValue:(short)defaultValue;

/*!
 @method nx_unsignedShortAtIndex:
 @abstract 获取指定index的unsigned short类型值
 @param index 索引号
 @result 返回unsigned short，获取失败为0
 */
- (unsigned short)nx_unsignedShortAtIndex:(NSUInteger)index;

/*!
 @method nx_unsignedShortAtIndex:defaultValue:
 @abstract 获取指定index的unsigned short类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned short，获取失败为指定的defaultValue
 */
- (unsigned short)nx_unsignedShortAtIndex:(NSUInteger)index defaultValue:(unsigned short)defaultValue;

/*!
 @method nx_intAtIndex:
 @abstract 获取指定index的int类型值
 @param index 索引号
 @result 返回int，获取失败为0
 */
- (int)nx_intAtIndex:(NSUInteger)index;

/*!
 @method nx_intAtIndex:defaultValue:
 @abstract 获取指定index的int类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回int，获取失败为指定的defaultValue
 */
- (int)nx_intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue;

/*!
 @method nx_unsignedIntAtIndex:
 @abstract 获取指定index的unsigned int类型值
 @param index 索引号
 @result 返回unsigned int，获取失败为0
 */
- (unsigned int)nx_unsignedIntAtIndex:(NSUInteger)index;

/*!
 @method nx_unsignedIntAtIndex:defaultValue:
 @abstract 获取指定index的unsigned int类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned int，获取失败为指定的defaultValue
 */
- (unsigned int)nx_unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue;

/*!
 @method nx_longAtIndex:
 @abstract 获取指定index的long类型值
 @param index 索引号
 @result 返回long，获取失败为0
 */
- (long)nx_longAtIndex:(NSUInteger)index;

/*!
 @method nx_longAtIndex:defaultValue:
 @abstract 获取指定index的long类型值
 @param defaultValue 获取失败要返回的值
 @result 返回long，获取失败为指定的defaultValue
 */
- (long)nx_longAtIndex:(NSUInteger)index defaultValue:(long)defaultValue;

/*!
 @method nx_unsignedLongAtIndex:
 @abstract 获取指定index的unsigned long类型值
 @param index 索引号
 @result 返回unsigned long，获取失败为0
 */
- (unsigned long)nx_unsignedLongAtIndex:(NSUInteger)index;

/*!
 @method nx_unsignedLongAtIndex:defaultValue:
 @abstract 获取指定index的unsigned long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long，获取失败为指定的defaultValue
 */
- (unsigned long)nx_unsignedLongAtIndex:(NSUInteger)index defaultValue:(unsigned long)defaultValue;

/*!
 @method nx_longLongAtIndex:
 @abstract 获取指定index的long long类型值
 @param index 索引号
 @result 返回long long，获取失败为0
 */
- (long long)nx_longLongAtIndex:(NSUInteger)index;

/*!
 @method nx_longLongAtIndex:defaultValue:
 @abstract 获取指定index的long long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回long long，获取失败为指定的defaultValue
 */
- (long long)nx_longLongAtIndex:(NSUInteger)index defaultValue:(long long)defaultValue;

/*!
 @method nx_unsignedLongLongAtIndex:
 @abstract 获取指定index的unsigned long long类型值
 @param index 索引号
 @result 返回unsigned long long，获取失败为0
 */
- (unsigned long long)nx_unsignedLongLongAtIndex:(NSUInteger)index;

/*!
 @method nx_unsignedLongLongAtIndex:defaultValue:
 @abstract 获取指定index的unsigned long long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long long，获取失败为指定的defaultValue
 */
- (unsigned long long)nx_unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long)defaultValue;

/*!
 @method nx_floatAtIndex:
 @abstract 获取指定index的float类型值
 @param index 索引号
 @result 返回float，获取失败为0.0
 */
- (float)nx_floatAtIndex:(NSUInteger)index;

/*!
 @method nx_floatAtIndex:defaultValue:
 @abstract 获取指定index的float类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回float，获取失败为指定的defaultValue
 */
- (float)nx_floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue;

/*!
 @method nx_doubleAtIndex:
 @abstract 获取指定index的double类型值
 @param index 索引号
 @result 返回double，获取失败为0.0
 */
- (double)nx_doubleAtIndex:(NSUInteger)index;

/*!
 @method nx_doubleAtIndex:defaultValue:
 @abstract 获取指定index的double类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回double，获取失败为指定的defaultValue
 */
- (double)nx_doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue;

/*!
 @method nx_boolAtIndex:
 @abstract 获取指定index的BOOL类型值
 @param index 索引号
 @result 返回BOOL，获取失败为NO
 */
- (BOOL)nx_boolAtIndex:(NSUInteger)index;

/*!
 @method nx_boolAtIndex:
 @abstract 获取指定index的BOOL类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回BOOL，获取失败为指定的defaultValue
 */
- (BOOL)nx_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue;

/*!
 @method nx_integerAtIndex:
 @abstract 获取指定index的NSInteger类型值
 @param index 索引号
 @result 返回NSInteger，获取失败为0
 */
- (NSInteger)nx_integerAtIndex:(NSUInteger)index;

/*!
 @method nx_integerAtIndex:defaultValue:
 @abstract 获取指定index的NSInteger类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSInteger，获取失败为指定的defaultValue
 */
- (NSInteger)nx_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue;

/*!
 @method nx_unsignedIntegerAtIndex:
 @abstract 获取指定index的NSUInteger类型值
 @param index 索引号
 @result 返回NSUInteger，获取失败为0
 */
- (NSUInteger)nx_unsignedIntegerAtIndex:(NSUInteger)index;

/*!
 @method nx_unsignedIntegerAtIndex:defaultValue:
 @abstract 获取指定index的NSUInteger类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSUInteger，获取失败为指定的defaultValue
 */
- (NSUInteger)nx_unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue;

/*!
 @method nx_pointAtIndex:
 @abstract 获取指定index的CGPoint类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGPointZero
 */
- (CGPoint)nx_pointAtIndex:(NSUInteger)index;

/*!
 @method nx_pointAtIndex:defaultValue:
 @abstract 获取指定index的CGPoint类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGPoint，获取失败为指定的defaultValue
 */
- (CGPoint)nx_pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue;

/*!
 @method nx_sizeAtIndex:
 @abstract 获取指定index的CGSize类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGSizeZero
 */
- (CGSize)nx_sizeAtIndex:(NSUInteger)index;

/*!
 @method nx_sizeAtIndex:defaultValue:
 @abstract 获取指定index的CGSize类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGSize，获取失败为指定的defaultValue
 */
- (CGSize)nx_sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue;

/*!
 @method nx_rectAtIndex:
 @abstract 获取指定index的CGRect类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGRectZero
 */
- (CGRect)nx_rectAtIndex:(NSUInteger)index;

/*!
 @method nx_rectAtIndex:
 @abstract 获取指定index的CGRect类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGRect，获取失败为指定的defaultValue
 */
- (CGRect)nx_rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue;

@end

@interface NSMutableArray (NXUtil)

/*!
 @method nx_addObjectsFromArrayCheck:
 @abstract 把另一个数组的所有元素添加到当前数组里
 @param otherArray 要添加数组
 */
- (void)nx_addObjectsFromArrayCheck:(NSArray *)otherArray;

/*!
 @method nx_addObjects:
 @abstract 把多个对象添加到数组里
 @param objects 要添加对象
 */
- (void)nx_addObjects:(id)objects, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 @method nx_addObjectCheck:
 @abstract 检查对象是不是为 nil ;不是则添加
 @param anObject 要添加对象
 */
- (void)nx_addObjectCheck:(id)anObject;

/*!
 @method nx_addChar:
 @abstract 添加char类型值，到数组里
 @param value 值
 */
- (void)nx_addChar:(char)value;

/*!
 @method nx_addUnsignedChar:
 @abstract 添加unsigned char类型值，到数组里
 @param value 值
 */
- (void)nx_addUnsignedChar:(unsigned char)value;

/*!
 @method nx_addShort:
 @abstract 添加short类型值，到数组里
 @param value 值
 */
- (void)nx_addShort:(short)value;

/*!
 @method nx_addUnsignedShort:
 @abstract 添加unsigned short类型值，到数组里
 @param value 值
 */
- (void)nx_addUnsignedShort:(unsigned short)value;

/*!
 @method nx_addInt:
 @abstract 添加int类型值，到数组里
 @param value 值
 */
- (void)nx_addInt:(int)value;

/*!
 @method nx_addUnsignedInt:
 @abstract 添加unsigned int类型值，到数组里
 @param value 值
 */
- (void)nx_addUnsignedInt:(unsigned int)value;

/*!
 @method nx_addLong:
 @abstract 添加long类型值，到数组里
 @param value 值
 */
- (void)nx_addLong:(long)value;

/*!
 @method nx_addUnsignedLong:
 @abstract 添加unsigned long类型值，到数组里
 @param value 值
 */
- (void)nx_addUnsignedLong:(unsigned long)value;

/*!
 @method nx_addLongLong:
 @abstract 添加long long类型值，到数组里
 @param value 值
 */
- (void)nx_addLongLong:(long long)value;

/*!
 @method nx_addUnsignedLongLong:
 @abstract 添加unsigned long long类型值，到数组里
 @param value 值
 */
- (void)nx_addUnsignedLongLong:(unsigned long long)value;

/*!
 @method nx_addFloat:
 @abstract 添加float类型值，到数组里
 @param value 值
 */
- (void)nx_addFloat:(float)value;

/*!
 @method nx_addDouble:
 @abstract 添加double类型值，到数组里
 @param value 值
 */
- (void)nx_addDouble:(double)value;

/*!
 @method nx_addBool:
 @abstract 添加BOOL类型值，到数组里
 @param value 值
 */
- (void)nx_addBool:(BOOL)value;

/*!
 @method nx_addInteger:
 @abstract 添加NSInteger类型值，到数组里
 @param value 值
 */
- (void)nx_addInteger:(NSInteger)value;

/*!
 @method nx_addUnsignedInteger:
 @abstract 添加NSUInteger类型值，到数组里
 @param value 值
 */
- (void)nx_addUnsignedInteger:(NSUInteger)value;

/*!
 @method nx_addPointValue:
 @abstract 添加CGPoint类型值，到数组里
 @param value 值
 */
- (void)nx_addPointValue:(CGPoint)value;

/*!
 @method nx_addSizeValue:
 @abstract 添加CGSize类型值，到数组里
 @param value 值
 */
- (void)nx_addSizeValue:(CGSize)value;

/*!
 @method nx_addRectValue:
 @abstract 添加CGRect类型值，到数组里
 @param value 值
 */
- (void)nx_addRectValue:(CGRect)value;

/*!
 @method nx_insertObjectCheck:atIndex:
 @abstract 检查插入指定索引号的对象是不是为nil和越界，不是则插入
 @param anObject 值
 @param index 插入到的索引号
 */
- (void)nx_insertObjectCheck:(id)anObject atIndex:(NSUInteger)index;

/*!
 @method nx_insertChar:atIndex:
 @abstract 插入指定索引号的char类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertChar:(char)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertUnsignedChar:atIndex:
 @abstract 插入指定索引号的unsigned char类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertUnsignedChar:(unsigned char)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertShort:atIndex:
 @abstract 插入指定索引号的short类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertShort:(short)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertUnsignedShort:atIndex:
 @abstract 插入指定索引号的unsigned short类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertUnsignedShort:(unsigned short)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertInt:atIndex:
 @abstract 插入指定索引号的int类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertInt:(int)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertUnsignedInt:atIndex:
 @abstract 插入指定索引号的unsigned int类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertUnsignedInt:(unsigned int)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertLong:atIndex:
 @abstract 插入指定索引号的long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertLong:(long)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertUnsignedLong:atIndex:
 @abstract 插入指定索引号的unsigned long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertUnsignedLong:(unsigned long)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertLongLong:atIndex:
 @abstract 插入指定索引号的long long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertLongLong:(long long)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertUnsignedLongLong:atIndex:
 @abstract 插入指定索引号的unsigned long long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertUnsignedLongLong:(unsigned long long)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertFloat:atIndex:
 @abstract 插入指定索引号的float类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertFloat:(float)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertDouble:atIndex:
 @abstract 插入指定索引号的double类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertDouble:(double)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertBool:atIndex:
 @abstract 插入指定索引号的BOOL类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertBool:(BOOL)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertInteger:atIndex:
 @abstract 插入指定索引号的NSInteger类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertInteger:(NSInteger)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertUnsignedInteger:atIndex:
 @abstract 插入指定索引号的NSUInteger类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertUnsignedInteger:(NSUInteger)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertPointValue:atIndex:
 @abstract 插入指定索引号的CGPoint类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertPointValue:(CGPoint)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertSizeValue:atIndex:
 @abstract 插入指定索引号的CGSize类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertSizeValue:(CGSize)value atIndex:(NSUInteger)index;

/*!
 @method nx_insertRectValue:atIndex:
 @abstract 插入指定索引号的CGRect类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)nx_insertRectValue:(CGRect)value atIndex:(NSUInteger)index;

/*!
 @method nx_replaceObjectCheckAtIndex:withChar:
 @abstract 检查指定索引号,的对象是不是为nil和越界，不是则替换
 @param index 替换的索引号
 @param anObject 值
 */
- (void)nx_replaceObjectCheckAtIndex:(NSUInteger)index withObject:(id)anObject;

/*!
 @method nx_replaceCharAtIndex:withChar:
 @abstract 指定索引号,替换char类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceCharAtIndex:(NSUInteger)index withChar:(char)value;

/*!
 @method nx_replaceUnsignedCharAtIndex:withUnsignedChar:
 @abstract 指定索引号,替换unsigned char类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceUnsignedCharAtIndex:(NSUInteger)index withUnsignedChar:(unsigned char)value;

/*!
 @method nx_replaceShortAtIndex:withShort:
 @abstract 指定索引号,替换short类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceShortAtIndex:(NSUInteger)index withShort:(short)value;

/*!
 @method nx_replaceUnsignedShortAtIndex:withUnsignedShort:
 @abstract 指定索引号,替换unsigned short类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceUnsignedShortAtIndex:(NSUInteger)index withUnsignedShort:(unsigned short)value;

/*!
 @method nx_replaceIntAtIndex:withInt:
 @abstract 指定索引号,替换int类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceIntAtIndex:(NSUInteger)index withInt:(int)value;

/*!
 @method nx_replaceUnsignedIntAtIndex:withUnsignedInt:
 @abstract 指定索引号,替换unsigned int类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceUnsignedIntAtIndex:(NSUInteger)index withUnsignedInt:(unsigned int)value;

/*!
 @method nx_replaceLongAtIndex:withLong:
 @abstract 指定索引号,替换long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceLongAtIndex:(NSUInteger)index withLong:(long)value;

/*!
 @method nx_replaceUnsignedLongAtIndex:withUnsignedLong:
 @abstract 指定索引号,替换unsigned long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceUnsignedLongAtIndex:(NSUInteger)index withUnsignedLong:(unsigned long)value;

/*!
 @method nx_replaceLongLongAtIndex:withLongLong:
 @abstract 指定索引号,替换long long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceLongLongAtIndex:(NSUInteger)index withLongLong:(long long)value;

/*!
 @method nx_replaceUnsignedLongLongAtIndex:withUnsignedLongLong:
 @abstract 指定索引号,替换unsigned long long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceUnsignedLongLongAtIndex:(NSUInteger)index withUnsignedLongLong:(unsigned long long)value;

/*!
 @method nx_replaceFloatAtIndex:withFloat:
 @abstract 指定索引号,替换float类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceFloatAtIndex:(NSUInteger)index withFloat:(float)value;

/*!
 @method nx_replaceDoubleAtIndex:withDouble:
 @abstract 指定索引号,替换double类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceDoubleAtIndex:(NSUInteger)index withDouble:(double)value;

/*!
 @method nx_replaceBoolAtIndex:withBool:
 @abstract 指定索引号,替换BOOL类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceBoolAtIndex:(NSUInteger)index withBool:(BOOL)value;

/*!
 @method nx_replaceIntegerAtIndex:withInteger:
 @abstract 指定索引号,替换NSInteger类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceIntegerAtIndex:(NSUInteger)index withInteger:(NSInteger)value;

/*!
 @method nx_replaceUnsignedIntegerAtIndex:withUnsignedInteger:
 @abstract 指定索引号,替换NSUInteger类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceUnsignedIntegerAtIndex:(NSUInteger)index withUnsignedInteger:(NSUInteger)value;

/*!
 @method nx_replacePointValueAtIndex:withPointValue:
 @abstract 指定索引号,替换CGPoint类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replacePointValueAtIndex:(NSUInteger)index withPointValue:(CGPoint)value;

/*!
 @method nx_replaceSizeValueAtIndex:withSizeValue:
 @abstract 指定索引号,替换CGSize类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceSizeValueAtIndex:(NSUInteger)index withSizeValue:(CGSize)value;

/*!
 @method nx_replaceRectValueAtIndex:withRectValue:
 @abstract 指定索引号,替换CGRect类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)nx_replaceRectValueAtIndex:(NSUInteger)index withRectValue:(CGRect)value;

/*!
 @method nx_removeObjectAtIndexCheck:
 @abstract 检查移除的index是不是在范围内;在是则移除
 @param index 索引号
 */
- (void)nx_removeObjectAtIndexCheck:(NSUInteger)index;
/*!
 @method nx_removeObjectsInRange:
 @abstract 删除范围内的元素
 @param range 删除的范围
 */
- (void)nx_removeObjectsInRange:(NSRange)range;

/*!
 @method nx_removeObject:
 @abstract 删除元素
 @param anObject 要删除的元素
 */
- (void)nx_removeObject:(id)anObject;;

/*!
 @method nx_insertObjects:atIndexes:
 @abstract 添加多个元素
 @param indexes 添加位置
 */
- (void)nx_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;

- (long)findFirstWithFilter:(BOOL (^_Nullable)(id _Nullable value))block;
///哈希的比较
- (NSUInteger)hash;
@end
