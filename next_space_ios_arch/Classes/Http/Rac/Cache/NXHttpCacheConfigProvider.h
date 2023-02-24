//
//  NXHttpCacheConfigProvider.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/24.
//

#import <Foundation/Foundation.h>
#import <next_space_ios_arch/NXTimeUnit.h>
#import <next_space_ios_arch/NXPath.h>
#import <next_space_ios_arch/XXF.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXHttpCacheConfigProvider : NSObject

 /**
   * 缓存目录 唯一标签 最好区分uid 或者token
   */
-(NSString *)getDirectory;

/**
 * 最大缓存空间 单位B
 */
-(NSUInteger)maxSize;

/**
   * 是否缓存 场用于 用于下游判断code是否应该缓存
   */
-(BOOL)isCache:(id)body;

/**
 全局默认缓存时间 NSTimeInterval== s
*/
-(long long)cacheTime;

@end

NS_ASSUME_NONNULL_END
