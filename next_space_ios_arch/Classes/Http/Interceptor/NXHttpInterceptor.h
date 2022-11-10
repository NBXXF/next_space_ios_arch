//
//  NXHttpInterceptor.h
//  AFNetworking
//  网络拦截器
//  Created by XXF on 2022/11/10.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXHttpInterceptor : NSObject

/**
 拦截处理
 常见设置header 设置公共参数 参数校验
 动态url设置等等
 **/
- (NSURLRequest *)interceptRequest:(NSURLRequest *)request;

@end

NS_ASSUME_NONNULL_END
