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
@end

NS_ASSUME_NONNULL_END
