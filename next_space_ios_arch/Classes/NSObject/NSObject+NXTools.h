//
//  NSObject+Describe.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import <Foundation/Foundation.h>
/**
 唯一标识 文件代码运行位置 没性能影响
 */
#define __FILE_LINE__ [NSString stringWithFormat:@"%s_%d",__FILE__, __LINE__]

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(NXTools)
@property (readonly, copy) NSString *simpleDescription;

/**
 转换成当前类的类型 本质 isKindOfClass,转换不成功会报错
 */
+ (instancetype)toKindOfClassObjectFrom:(NSObject *_Nullable)fromObject;

/**
 转换成当前类的类型 本质 isKindOfClass,转换不成功返回nil
 */
+ (nullable instancetype)toKindOfClassObjectOrNilFrom:(NSObject *_Nullable)fromObject;

/**
 转换成当前类的类型 本质 isMemberOfClass,转换不成功会报错
 */
+ (instancetype)toMemberOfClassObjectFrom:(NSObject *_Nullable)fromObject;

/**
 转换成当前类的类型 本质 isMemberOfClass,转换不成功返回nil
 */
+ (nullable instancetype)toMemberOfClassObjectOrNilFrom:(NSObject *_Nullable)fromObject;


/**
 替代init【万能初始化方法 】与#applyWithBlock的区别 【是会执行init方法】
 第三方框架已经有很多initWithBlock了 避免冲突取名为 initByBlock 直译 通过(by ) Block 来初始化
 */
- (instancetype)initByBlock:(void (^)(id it))block;

/**
 常用于初始化对象或更改对象属性 返回值自己,【注意 不会执行init方法,理解为装饰自己(可以n次),首先得有自己】
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
