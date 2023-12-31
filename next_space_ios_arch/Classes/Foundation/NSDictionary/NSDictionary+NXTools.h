//
//  NSDictionary+NXTools.h
//  AFNetworking
//
//  Created by XXF on 2022/12/8.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/RACTuple.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType>(NXTools)

/**
 变换整体
 */
-(instancetype)applyWithBlock:(void (^)(NSDictionary<KeyType,ObjectType> *it))block;

/**
 变换每一个item类型
 */
- (NSMutableDictionary *)mapReplaceEachWithBlock:(RACTwoTuple * (^)(KeyType key,ObjectType value))block;


/**
 筛选出满足条件的对象集合
 */
- (NSMutableDictionary<KeyType,ObjectType> *)filterObjectWithBlock:(BOOL (^)(KeyType key,ObjectType value))block;
- (NSMutableArray<KeyType> *)filterKeyWithBlock:(BOOL (^)(KeyType key,ObjectType value))block;
- (NSMutableArray<ObjectType> *)filterValueWithBlock:(BOOL (^)(KeyType key,ObjectType value))block;


/**
 查找满足条件的第一个
 */
-(RACTwoTuple<KeyType, ObjectType> *)firstObjectWithBlock:(BOOL (^)(KeyType key,ObjectType value))block;
-(KeyType)firstKeyWithBlock:(BOOL (^)(KeyType key,ObjectType value))block;
-(ObjectType)firstValueWithBlock:(BOOL (^)(KeyType key,ObjectType value))block;


/**
 先判读类型 如果类型符合就转换,否则重新生成新的类型
 */
-(NSMutableDictionary<KeyType,ObjectType> *)mutableCopyOrCast;

/**
 先判读类型 如果类型符合就转换,否则重新生成新的类型
 */
-(NSDictionary<KeyType,ObjectType> *)copyOrCast;
@end

NS_ASSUME_NONNULL_END
