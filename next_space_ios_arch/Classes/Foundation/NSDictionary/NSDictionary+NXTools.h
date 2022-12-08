//
//  NSDictionary+NXTools.h
//  AFNetworking
//
//  Created by XXF on 2022/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType>(NXTools)
/**
 筛选出满足条件的对象集合
 */
- (NSMutableDictionary<KeyType,ObjectType> *)filterObjectWithBlock:(BOOL (^)(KeyType key,ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END
