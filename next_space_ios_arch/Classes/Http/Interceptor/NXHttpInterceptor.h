//
//  NXHttpInterceptor.h
//  AFNetworking
//  网络拦截器  替代requestSerializer setValue:value forHTTPHeaderField:key 这种方式(afn 只是http method 上传下载没有,且不是动态拦截,需要静态设置不是很好)
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


/**
 拦截响应 暂时无法自定义返回
 常用语缓存 或者 获取后端响应的header逻辑
 */
-(void)interceptResponse:(NSURLSessionTask * _Nonnull) task error:(NSError * _Nullable) error;

@end

NS_ASSUME_NONNULL_END
