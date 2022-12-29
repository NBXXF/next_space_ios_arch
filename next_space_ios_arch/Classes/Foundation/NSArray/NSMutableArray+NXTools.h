//
//  NSMutableArray+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType>(NXTools)
/**
 变换整体
 */
-(NSMutableArray<ObjectType> *)applyWithBlock:(void (^)( NSMutableArray<ObjectType> *it))block;
@end

NS_ASSUME_NONNULL_END
