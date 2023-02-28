//
//  NXHTTPSessionManager.h
//  NXHTTP
//  rac进行拓展
//  Created by XXF on 2022/11/9.
//

#import "NXHTTPSessionManager+RACSingal.h"
NSString * const NXNetworkingTaskRequestUrlKey = @"com.xxf.http.request.url";
NSString * const NXNetworkingTaskRequestMethodKey = @"com.xxf.http.request.method";
NSString * const NXNetworkingTaskRequestParametersKey = @"com.xxf.http.request.parameters";
NSString * const NXNetworkingTaskRequestHeadersKey = @"com.xxf.http.request.headers";
NSString * const NXNetworkingTaskResponseHeadersKey = @"com.xxf.http.response.headers";
NSString * const NXNetworkingTaskResponseCodeKey= @"com.xxf.http.response.code";
NSString * const NXNetworkingTaskResponseMimeTypeKey= @"com.xxf.http.response.mime";
NSString * const NXNetworkingTaskResponseIsCacheKey=@"com.xxf.http.response.isCache";

@implementation NXHTTPSessionManager(RACSingal)

- (RACSignal<NXSessionDataTaskResult *> *)GETSignal:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                           progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self GET:URLString parameters:parameters headers:headers progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:NXRequestTypeGET URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [subscriber sendError:[self wrapHttpErrorWithMethod:NXRequestTypeGET URLString:URLString parameters:parameters headers:headers task:task error:error]];
       }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}


- (RACSignal<NXSessionDataTaskResult *> *)HEADSignal:(NSString *)URLString
                    parameters:(nullable id)parameters
                                             headers:(nullable NSDictionary<NSString *,NSString *> *)headers{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self  HEAD:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:NXRequestTypeHEAD URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=nil;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:NXRequestTypeHEAD URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}


- (RACSignal<NXSessionDataTaskResult *> *)POSTSignal:(NSString *)URLString
                             parameters:(nullable id)parameters
                                headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                            progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self POST:URLString parameters:parameters headers:headers progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:NXRequestTypePOST URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:NXRequestTypePOST URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}



- (RACSignal<NXSessionDataTaskResult *> *)POSTSignal:(NSString *)URLString
                    parameters:(nullable id)parameters
                       headers:(nullable NSDictionary<NSString *,NSString *> *)headers
     constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
                                            progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self POST:URLString parameters:parameters headers:headers constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:NXRequestTypePOST URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:NXRequestTypePOST URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}



- (RACSignal<NXSessionDataTaskResult *> *)PUTSignal:(NSString *)URLString
                            parameters:(nullable id)parameters
                                            headers:(nullable NSDictionary <NSString *, NSString *> *)headers{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self PUT:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:NXRequestTypePUT URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:NXRequestTypePUT URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}



- (RACSignal<NXSessionDataTaskResult *> *)PATCHSignal:(NSString *)URLString
                              parameters:(nullable id)parameters
                                              headers:(nullable NSDictionary <NSString *, NSString *> *)headers{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self PATCH:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:NXRequestTypePATCH URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:NXRequestTypePATCH URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}



- (RACSignal<NXSessionDataTaskResult *> *)DELETESignal:(NSString *)URLString
                               parameters:(nullable id)parameters
                                               headers:(nullable NSDictionary <NSString *, NSString *> *)headers{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self DELETE:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:NXRequestTypeDELETE URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:NXRequestTypeDELETE URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}


- (RACSignal<NXSessionDataTaskResult *> *)dataTaskWithHTTPMethodSignal:(NXRequestType)method
                                                URLString:(NSString *)URLString
                                               parameters:(nullable id)parameters
                                                  headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                           uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                                      downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self dataTaskWithHTTPMethod:method URLString:URLString parameters:parameters headers:headers uploadProgress:uploadProgress downloadProgress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:method URLString:URLString parameters:parameters headers:headers task:nil];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:method URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
        return [RACDisposable disposableWithBlock:^{
            if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
                [task cancel];
            }
        }];
     }];
}


- (NSMutableDictionary *)wrapHttpUserInfoWithMethod:(NXRequestType)method
                                          URLString:(NSString *)URLString
                                         parameters:(id)parameters
                                            headers:(NSDictionary<NSString *,NSString *> *)headers
                                               task:(NSURLSessionDataTask * _Nullable)task
{
    NSMutableDictionary *newUserInfo=[NSMutableDictionary dictionary];
    if(method){
        [newUserInfo setObject:method forKey:NXNetworkingTaskRequestMethodKey];
    }
    if(URLString){
        [newUserInfo setObject:URLString forKey:NXNetworkingTaskRequestUrlKey];
    }
    if(parameters){
        [newUserInfo setObject:parameters forKey:NXNetworkingTaskRequestParametersKey];
    }
    if(headers){
        [newUserInfo setObject:headers forKey:NXNetworkingTaskRequestHeadersKey];
    }
    if(task){
        if([task.response isKindOfClass:NSHTTPURLResponse.class]){
            NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
            NSDictionary *headerFields = response.allHeaderFields;
            NSString *mimeType=response.MIMEType;
            [newUserInfo setObject:@(response.statusCode) forKey:NXNetworkingTaskResponseCodeKey];
            if(headerFields){
                [newUserInfo setObject:headerFields forKey:NXNetworkingTaskResponseHeadersKey];
            }
            if(mimeType){
                [newUserInfo setObject:mimeType forKey:NXNetworkingTaskResponseMimeTypeKey];
            }
        }
    }
    return newUserInfo;
}

/**
 包装异常
 */
-(NSError *)wrapHttpErrorWithMethod:(NXRequestType)method
                   URLString:(NSString *)URLString
                  parameters:(nullable id)parameters
                     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                        task:(NSURLSessionDataTask * _Nullable)task
                       error:(NSError *)error
{
    /**
     序列化失败  task=nil 请参考源码 AFHTTPSessionManager#dataTaskWithHTTPMethod
     */
    NSMutableDictionary *newUserInfo=[self wrapHttpUserInfoWithMethod:method
                                                            URLString:URLString
                                                           parameters:parameters
                                                              headers:headers task:task];
    if(error.userInfo){
        [newUserInfo addEntriesFromDictionary:error.userInfo];
    }
    return [NSError errorWithDomain:error.domain code:error.code userInfo:newUserInfo];
}

@end
