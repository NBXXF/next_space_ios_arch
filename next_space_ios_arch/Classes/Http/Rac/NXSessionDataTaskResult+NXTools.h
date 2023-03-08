//
//  NXSessionDataTaskResult+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/5/24.
//

#import <Foundation/Foundation.h>
#import <next_space_ios_arch/NXSessionDataTaskResult.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXSessionDataTaskResult(NXTools)
/**
 对应NSDictory 和NSArray
 */
@property(nonatomic,assign,readonly) BOOL isJSON;

/**
 对应NSData
 */
@property(nonatomic,assign,readonly) BOOL isBinary;

/**
 是否是来自缓存的
 */
@property(nonatomic,assign,readonly) BOOL isCache;


/**
 进行将自己的合并 生产一个新的userInfo
 */
-(NSMutableDictionary *)mergeUserInfoWithInfo:(NSDictionary *)from;
@end

NS_ASSUME_NONNULL_END
