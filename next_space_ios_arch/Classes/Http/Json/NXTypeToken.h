//
//  NXTypeToken.h
//  next_space_ios_arch
//  用于描述json 解析的结构类型
//  Created by XXF on 2022/11/9.
//


/**
 解析常见类型 Model=T 来描述
 T
 NSMutableArray<T>
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXTypeToken : NSObject
@property(nonatomic,strong,readonly) Class classType;
@property(nonatomic,assign,readonly) BOOL isArray;

/**
 解析成 NSMutableArray<T>
 */
+(NXTypeToken *(^)(Class classType))arrayTypeToken;

/**
 解析成T
 */
+(NXTypeToken *(^)(Class classType))objectTypeToken;

@end

NS_ASSUME_NONNULL_END
