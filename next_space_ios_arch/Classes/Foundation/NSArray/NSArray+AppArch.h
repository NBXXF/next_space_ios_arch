//
//  NSArray+AppArch.h
//  JLRoutes
//
//  Created by XXF on 2022/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType>(AppArch)

/**
 变换整体
 */
-(instancetype)applyWithBlock:(void(^)(NSArray<ObjectType> *it))block;


/**
 变换每一个item类型
 */
- (NSMutableArray *)mapReplaceEachWithBlock:(id (^)(ObjectType value))block;


/**
 查找满足条件的第一个
 */
-(ObjectType)firstObjectWithBlock:(BOOL (^)(ObjectType value))block;

/**
 查找满足条件的最后
 */
-(ObjectType)lastObjectWithBlock:(BOOL (^)(ObjectType value))block;


/**
 查找满足条件的位置
 */
- (NSUInteger)indexOfObjectWithBlock:(BOOL (^)(ObjectType value))block;

/**
 查找是否包含满足条件的元素
 */
- (BOOL)containsObjectWithBlock:(BOOL (^)(ObjectType value))block;


/**
 所有对象是否一样
 */
-(BOOL)allObjectEqualWithBlock:(BOOL (^)(ObjectType first,ObjectType obj))block;


/**
 筛选出满足条件的对象集合
 */
- (NSMutableArray<ObjectType> *)filterObjectWithBlock:(BOOL (^)(ObjectType value))block;

/**
 移除满足条件的第一个
 */
-(NSMutableArray<ObjectType> *)removeFirstObjectWithBlock:(BOOL (^)(ObjectType value))block;

/**
 移除满足条件的所有
 */
-(NSMutableArray<ObjectType> *)removeObjectWithBlock:(BOOL (^)(ObjectType value))block;

/**
 转换成字典 自定义key
 */
- (NSMutableDictionary<id,ObjectType> *)associateObjectBy:(id (^)(ObjectType value))keyBlock;


/**
 转换成字典 自定义key 自定义value
 */
- (NSMutableDictionary<id,id> *)associateObjectBy:(id (^)(ObjectType obj))keyBlock valueBlock:(id (^)(ObjectType obj))valueBlock;


/**
 先判读类型 如果类型符合就转换,否则重新生成新的类型
 */
-(NSMutableArray<ObjectType> *)mutableCopyOrCast;

/**
 先判读类型 如果类型符合就转换,否则重新生成新的类型
 */
-(NSArray<ObjectType> *)copyOrCast;


/**
 拼接字符串
 */
- (NSString *)componentsJoinedByString:(NSString *)separator objectMapBlock:(NSString * (^)(ObjectType value))block;
@end

NS_ASSUME_NONNULL_END
