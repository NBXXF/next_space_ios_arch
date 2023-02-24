//
//  NXNetCacheFactory.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/5/24.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache-umbrella.h>
#import <next_space_ios_arch/SingletonUtils.h>
#import <next_space_ios_arch/NXHttpCacheConfigProvider.h>
NS_ASSUME_NONNULL_BEGIN

@interface NXNetCacheFactory : NSObject
singleton_interface(NXNetCacheFactory)

-(YYDiskCache *)getCache:(NXHttpCacheConfigProvider *)provider;
@end

NS_ASSUME_NONNULL_END
