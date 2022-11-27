//
//  NSMutableArray+AppArch.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType>(AppArch)

//返回自己 等同于kotlin的apply高阶函数
-(NSMutableArray<ObjectType> *)applyWithBlock:(void (^)(NSMutableArray<ObjectType> *it))block;
@end

NS_ASSUME_NONNULL_END
