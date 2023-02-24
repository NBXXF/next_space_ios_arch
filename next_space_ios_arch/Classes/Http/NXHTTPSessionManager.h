//
//  NXHTTPSessionManager.h
//  NXHTTP
//  解决AFN下载bug 并进行拓展
//  Created by XXF on 2022/11/9.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "NXHttpInterceptor.h"
#import <next_space_ios_arch/NXHttpCacheConfigProvider.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXHTTPSessionManager : AFHTTPSessionManager

/*
 网络缓存配置的提供类
 */
@property(nonatomic,strong)NXHttpCacheConfigProvider *cacheConfigProvider;

/**
 添加拦截器
 */
-(void)addInterceptor:(NXHttpInterceptor *)interceptor;


/**
 移除拦截器
 */
-(void)removeInterceptor:(NXHttpInterceptor *)interceptor;


/**
 下载
 */
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request progress:(void (^)(NSProgress * _Nonnull))downloadProgressBlock destinationPath:(NSString *)destinationPath completionHandler:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nullable, NSError * _Nullable))completionHandler;

@end

NS_ASSUME_NONNULL_END
