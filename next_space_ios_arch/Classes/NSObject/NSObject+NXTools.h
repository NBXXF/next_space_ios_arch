//
//  NSObject+Describe.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(NXTools)
@property (readonly, copy) NSString *simpleDescription;

/**
 转换成当前类的类型 本质 isKindOfClass,转换不成功会报错
 */
+ (instancetype)toKindOfClassObjectFrom:(NSObject *)fromObject;

/**
 转换成当前类的类型 本质 isKindOfClass,转换不成功返回nil
 */
+ (nullable instancetype)toKindOfClassObjectOrNilFrom:(NSObject *)fromObject;

/**
 转换成当前类的类型 本质 isMemberOfClass,转换不成功会报错
 */
+ (instancetype)toMemberOfClassObjectFrom:(NSObject *)fromObject;

/**
 转换成当前类的类型 本质 isMemberOfClass,转换不成功返回nil
 */
+ (nullable instancetype)toMemberOfClassObjectOrNilFrom:(NSObject *)fromObject;


/**
 常用于初始化对象或更改对象属性 返回值自己
 it为当前对象
 */
- (instancetype)applyWithBlock:(void (^)(id it))block;

/**
 将自己变换为其他对象
 it为当前对象
 */
- (id)mapWithBlock:(id (^)(id it))block DEPRECATED_MSG_ATTRIBUTE("请使用mapReplaceWithBlock");

/**
 将自己变换为其他对象
 it为当前对象
 */
- (id)mapReplaceWithBlock:(id (^)(id it))block;

@end

NS_ASSUME_NONNULL_END
