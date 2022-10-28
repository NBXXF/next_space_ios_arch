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
 变换类型
 */
- (NSMutableArray *)mapObjectWithBlock:(id (^)(ObjectType obj))block;

/**
 查找满足条件的第一个
 */
-(ObjectType)firstObjectWithBlock:(BOOL (^)(ObjectType obj))block;

/**
 查找满足条件的最后
 */
-(ObjectType)lastObjectWithBlock:(BOOL (^)(ObjectType obj))block;


/**
 查找满足条件的位置
 */
- (NSUInteger)indexOfObjectWithBlock:(BOOL (^)(ObjectType obj))block;


/**
 筛选出满足条件的对象集合
 */
- (NSMutableArray<ObjectType> *)filterObjectWithBlock:(BOOL (^)(ObjectType obj))block;


/**
 转换成字典 自定义key
 */
- (NSMutableDictionary<id,ObjectType> *)associateObjectBy:(id (^)(ObjectType obj))keyBlock;


/**
 转换成字典 自定义key 自定义value
 */
- (NSMutableDictionary<id,id> *)associateObjectBy:(id (^)(ObjectType obj))keyBlock valueBlock:(id (^)(ObjectType obj))valueBlock;

@end

NS_ASSUME_NONNULL_END
