//
//  NXHTTPSessionManager.h
//  NXHTTP
//  rac进行拓展
//  Created by XXF on 2022/11/9.
//

#import "NXHTTPSessionManager+RACSingal.h"
NSString * const NXNetworkingTaskUrlKey = @"com.xxf.http.url";
NSString * const NXNetworkingTaskMethodKey = @"com.xxf.http.method";
NSString * const NXNetworkingTaskParametersKey = @"com.xxf.http.parameters";
NSString * const NXNetworkingTaskHeadersKey = @"com.xxf.http.headers";
//NSString * const NXNetworkingTaskDidFailDataTaskKey = @"com.xxf.http.dataTask";//可能是没有的 序列化异常就没有

@implementation NXHTTPSessionManager(RACSingal)

- (RACSignal<NXSessionDataTaskResult *> *)GETSignal:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                           progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self GET:URLString parameters:parameters headers:headers progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [subscriber sendError:[self wrapHttpErrorWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers task:task error:error]];
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
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
            result.responseObject=nil;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:@"HEAD" URLString:URLString parameters:parameters headers:headers task:task error:error]];
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
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:@"POST" URLString:URLString parameters:parameters headers:headers task:task error:error]];
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
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:@"POST" URLString:URLString parameters:parameters headers:headers task:task error:error]];
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
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:@"PUT" URLString:URLString parameters:parameters headers:headers task:task error:error]];
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
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:@"PATCH" URLString:URLString parameters:parameters headers:headers task:task error:error]];
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
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
            result.responseObject=responseObject;
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:[self wrapHttpErrorWithMethod:@"DELETE" URLString:URLString parameters:parameters headers:headers task:task error:error]];
        }];
       return [RACDisposable disposableWithBlock:^{
           if(task&&(task.state==NSURLSessionTaskStateRunning||task.state== NSURLSessionTaskStateSuspended)){
               [task cancel];
           }
       }];
    }];
}


- (RACSignal<NXSessionDataTaskResult *> *)dataTaskWithHTTPMethodSignal:(NSString *)method
                                                URLString:(NSString *)URLString
                                               parameters:(nullable id)parameters
                                                  headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                                           uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                                      downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        __block NSURLSessionDataTask *task= [self dataTaskWithHTTPMethod:method URLString:URLString parameters:parameters headers:headers uploadProgress:uploadProgress downloadProgress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
            result.userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers];
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

- (NSMutableDictionary *)wrapHttpUserInfoWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(id)parameters headers:(NSDictionary<NSString *,NSString *> *)headers{
    NSMutableDictionary *newUserInfo=[NSMutableDictionary dictionary];
    if(method){
        [newUserInfo setObject:method forKey:NXNetworkingTaskMethodKey];
    }
    if(URLString){
        [newUserInfo setObject:URLString forKey:NXNetworkingTaskUrlKey];
    }
    if(parameters){
        [newUserInfo setObject:parameters forKey:NXNetworkingTaskParametersKey];
    }
    if(headers){
        [newUserInfo setObject:headers forKey:NXNetworkingTaskHeadersKey];
    }
    return newUserInfo;
}

/**
 包装异常
 */
-(NSError *)wrapHttpErrorWithMethod:(NSString *)method
                   URLString:(NSString *)URLString
                  parameters:(nullable id)parameters
                     headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                        task:(NSURLSessionDataTask * _Nullable)task
                       error:(NSError *)error
{
    /**
     序列化失败  task=nil 请参考源码 AFHTTPSessionManager#dataTaskWithHTTPMethod
     */
    NSMutableDictionary *newUserInfo=[self wrapHttpUserInfoWithMethod:method URLString:URLString parameters:parameters headers:headers];
    if(error.userInfo){
        [newUserInfo addEntriesFromDictionary:error.userInfo];
    }
//    if(task){
//        [newUserInfo setObject:task forKey:NXNetworkingTaskDidFailDataTaskKey];
//    }
    return [NSError errorWithDomain:error.domain code:error.code userInfo:newUserInfo];
}

@end
