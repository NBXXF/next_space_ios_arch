//
//  NSMutableDictionary+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary<KeyType,ObjectType>(NXTools)
/**
 变换整体
 */
-(NSMutableDictionary<KeyType,ObjectType> *)applyWithBlock:(NSMutableDictionary<KeyType,ObjectType> * (^)(NSMutableDictionary<KeyType,ObjectType> *it))block;
@end

NS_ASSUME_NONNULL_END
