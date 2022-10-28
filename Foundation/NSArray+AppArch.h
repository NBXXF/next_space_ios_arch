//
//  NSArray+AppArch.h
//  JLRoutes
//
//  Created by XXF on 2022/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType>(AppArch)
-(ObjectType)firstObjectWithBlock:(BOOL (^)(ObjectType _Nullable obj))block;
@end

NS_ASSUME_NONNULL_END
