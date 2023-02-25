//
//  NXHTTPSessionManager.h
//  NXHTTP
//  rac进行拓展
//  Created by XXF on 2022/11/9.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC-umbrella.h>
#import <next_space_ios_arch/NXHTTPSessionManager.h>
#import <next_space_ios_arch/NXSessionDataTaskResult.h>
#import <next_space_ios_arch/NXRequestType.h>

NS_ASSUME_NONNULL_BEGIN


/**
 增加异常的时候 返回对应的请求 给下游处理
 */
FOUNDATION_EXPORT NSString * const NXNetworkingTaskRequestUrlKey;
FOUNDATION_EXPORT NSString * const NXNetworkingTaskRequestMethodKey;
FOUNDATION_EXPORT NSString * const NXNetworkingTaskRequestParametersKey;
FOUNDATION_EXPORT NSString * const NXNetworkingTaskRequestHeadersKey;
FOUNDATION_EXPORT NSString * const NXNetworkingTaskResponseHeadersKey;
FOUNDATION_EXPORT NSString * const NXNetworkingTaskResponseIsCacheKey;



@interface NXHTTPSessionManager(RACSingal)

- (RACSignal<NXSessionDataTaskResult *> *)GETSignal:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                         progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress;


- (RACSignal<NXSessionDataTaskResult *> *)HEADSignal:(NSString *)URLString
                    parameters:(nullable id)parameters
                                       headers:(nullable NSDictionary<NSString *,NSString *> *)headers;


- (RACSignal<NXSessionDataTaskResult *> *)POSTSignal:(NSString *)URLString
                             parameters:(nullable id)parameters
                                headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress;



- (RACSignal<NXSessionDataTaskResult *> *)POSTSignal:(NSString *)URLString
                    parameters:(nullable id)parameters
                       headers:(nullable NSDictionary<NSString *,NSString *> *)headers
     constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress;



- (RACSignal<NXSessionDataTaskResult *> *)PUTSignal:(NSString *)URLString
                            parameters:(nullable id)parameters
                               headers:(nullable NSDictionary <NSString *, NSString *> *)headers;



- (RACSignal<NXSessionDataTaskResult *> *)PATCHSignal:(NSString *)URLString
                              parameters:(nullable id)parameters
                                 headers:(nullable NSDictionary <NSString *, NSString *> *)headers;



- (RACSignal<NXSessionDataTaskResult *> *)DELETESignal:(NSString *)URLString
                               parameters:(nullable id)parameters
                                  headers:(nullable NSDictionary <NSString *, NSString *> *)headers;


- (RACSignal<NXSessionDataTaskResult *> *)dataTaskWithHTTPMethodSignal:(NXRequestType)method
                                                URLString:(NSString *)URLString
                                               parameters:(nullable id)parameters
                                                  headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                           uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                         downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress;

-(NSMutableDictionary *)wrapHttpUserInfoWithMethod:(NXRequestType)method
                   URLString:(NSString *)URLString
                  parameters:(nullable id)parameters
                               headers:(nullable NSDictionary <NSString *, NSString *> *)headers;
/**
 包装网络异常
 */
-(NSError *)wrapHttpErrorWithMethod:(NXRequestType)method
                   URLString:(NSString *)URLString
                  parameters:(nullable id)parameters
                     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                        task:(NSURLSessionDataTask * _Nullable)task
                          error:(NSError *)error;
@end

NS_ASSUME_NONNULL_END
