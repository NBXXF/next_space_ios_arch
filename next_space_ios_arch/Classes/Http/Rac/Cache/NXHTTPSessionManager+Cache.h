//
//  NXHTTPSessionManager+Cache.h
//  AFNetworking
//
//  Created by 1234 on 2023/2/23.
//

#import <Foundation/Foundation.h>
#import <next_space_ios_arch/NXHTTPSessionManager+RACSingal.h>
#import <next_space_ios_arch/NXNetCacheType.h>
NS_ASSUME_NONNULL_BEGIN

@interface NXHTTPSessionManager(Cache)
- (RACSignal<NXSessionDataTaskResult *> *)GETSignal:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                         progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress cacheType:(NXNetCacheType)cacheType
                             cacheTime:(long long)cacheTime;


@end

NS_ASSUME_NONNULL_END
