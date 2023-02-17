//
//  NSSet+NXTools.h
//  AFNetworking
//
//  Created by XXF on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet<__covariant ObjectType>(NXTools)

/**
 筛选出满足条件的对象集合
 */
- (ObjectType)filterObjectWithBlock:(BOOL (^)(ObjectType value))block;

@end

NS_ASSUME_NONNULL_END
