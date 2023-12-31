//
//  NXHTTPSessionManager+Cache.m
//  AFNetworking
//
//  Created by XXF on 2023/2/23.
//

#import "NXHTTPSessionManager+Cache.h"
#import <YYModel/YYModel.h>
#import <next_space_ios_arch/NSString+NXUtil.h>
#import <next_space_ios_arch/StringUtils.h>
#import <next_space_ios_arch/RACSignal+AppArch.h>
#import <next_space_ios_arch/NXNetCacheFactory.h>
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <next_space_ios_arch/NSDate+NXTools.h>
#import <next_space_ios_arch/NSDictionary+NXTools.h>

@implementation NXHTTPSessionManager(Cache)
- (RACSignal<NXSessionDataTaskResult *> *)GETSignal:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                         progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress cacheType:(NXNetCacheType)cacheType
                                          cacheTime:(long long)cacheTime{
    
    /**
     /// 只走网络
     NXNetCacheTypeOnlyRemote = 0,
     /// 先网络,没有网络 就走本地
     NXNetCacheTypeFirstRemote = 1,
     /// 先本地  后网络  如果本地没有就回调一次  否则回调两次
     NXNetCacheTypeFirstCache = 2,
     /// 如果本地有就走本地  没有就走网络 只走一次 有没有 都会继续请求接口 覆盖新数据
     NXNetCacheTypeIfCache = 3,
     ///只走本地 判断是否需要显示下拉刷新用的
     NXNetCacheTypeOnlyCache = 4,
     */
    RACSignal<NXSessionDataTaskResult *> *request;
    __block NSString *key=[self _cacheKeyWithURL:URLString parameters:parameters];
    __block NSDictionary *userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers task:nil];
    switch (cacheType) {
        case NXNetCacheTypeIfRemote:{
            request= [[[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress] doNext:^(NXSessionDataTaskResult * _Nullable x) {
                [self _cacheDataWithKey:key taskData:x];
            }] onErrorResumeNext:^RACSignal<NXSessionDataTaskResult *> * _Nonnull(NSError * _Nonnull error) {
                if([self _isNetConnectError:error]){
                    return [[self _getCacheDataWithKey:key cacheTime:cacheTime userInfo:userInfo] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                        if(value){
                            return [RACSignal just:value];
                        }else{
                            return [RACSignal empty];
                        }
                    }];
                }else{
                    return [RACSignal error:error];
                }
            }];
        }
            break;
        case NXNetCacheTypeFirstCache:{
            request = [
                [[[self _getCacheDataWithKey:key cacheTime:cacheTime userInfo:userInfo] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                    if(value){
                        return [RACSignal just:value];
                    }else{
                        return [RACSignal empty];
                    }
                }] onErrorResumeNext:^RACSignal * _Nonnull(NSError * _Nonnull error) {
                    return [[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress] doNext:^(NXSessionDataTaskResult * _Nullable x) {
                        [self _cacheDataWithKey:key taskData:x];
                    }];
                }]
                concat:
                 [[[self GETSignal:URLString
                        parameters:parameters
                           headers:headers
                          progress:downloadProgress] doNext:^(NXSessionDataTaskResult * _Nullable x) {
                     [self _cacheDataWithKey:key taskData:x];
                   }] onErrorResumeNext:^RACSignal<NXSessionDataTaskResult *> * _Nonnull(NSError * _Nonnull error) {
                       //这里 没有java 的concatDeleayError  错误的时候先返回缓存,下游有延迟,或者没有网的情况会立即断整个流
                     return [[self _getCacheDataWithKey:key cacheTime:cacheTime userInfo:userInfo] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                         if(value){
                             return [RACSignal just:value];
                         }else{
                             return [RACSignal empty];
                         }
                     }];
                 }]
            ];
        }
            break;
        case NXNetCacheTypeIfCache:{
            request = [[[self _getCacheDataWithKey:key cacheTime:cacheTime userInfo:userInfo] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                if(value){
                    return [RACSignal just:value];
                }else{
                    //去获取网络
                    return [[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress] doNext:^(NXSessionDataTaskResult * _Nullable x) {
                        [self _cacheDataWithKey:key taskData:x];
                    }];
                }
            }] onErrorResumeNext:^RACSignal * _Nonnull(NSError * _Nonnull error) {
                return [[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress] doNext:^(NXSessionDataTaskResult * _Nullable x) {
                    [self _cacheDataWithKey:key taskData:x];
                }];
            }];
        }
            break;
        case NXNetCacheTypeOnlyCache:{
            request = [self _getCacheDataWithKey:key cacheTime:cacheTime userInfo:userInfo];
        }
            break;
        case NXNetCacheTypeOnlyRemote:{
            request= [[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress] doNext:^(NXSessionDataTaskResult * _Nullable x) {
                [self _cacheDataWithKey:key taskData:x];
            }];
        }
            break;
        default:{
            request= [[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress] doNext:^(NXSessionDataTaskResult * _Nullable x) {
                [self _cacheDataWithKey:key taskData:x];
            }];
        }
            break;
    }
    return request;
}


- (RACSignal<NXSessionDataTaskResult *> *)POSTSignal:(NSString *)URLString
                                          parameters:(id)parameters
                                             headers:(NSDictionary<NSString *,NSString *> *)headers
                                            progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                           cacheType:(NXNetCacheType)cacheType
                                           cacheTime:(long long)cacheTime{
    RACSignal<NXSessionDataTaskResult *> *request;
    __block NSString *key=[self _cacheKeyWithURL:URLString parameters:parameters];
    __block NSDictionary *userInfo=[self wrapHttpUserInfoWithMethod:@"GET" URLString:URLString parameters:parameters headers:headers task:nil];
    switch (cacheType) {
        case NXNetCacheTypeIfRemote:{
            request= [[[self POSTSignal:URLString
                             parameters:parameters
                                headers:headers
                               progress:uploadProgress]
                       doNext:^(NXSessionDataTaskResult * _Nullable x) {
                [self _cacheDataWithKey:key taskData:x];
            }] onErrorResumeNext:^RACSignal<NXSessionDataTaskResult *> * _Nonnull(NSError * _Nonnull error) {
                if([self _isNetConnectError:error]){
                    return [[self _getCacheDataWithKey:key
                                             cacheTime:cacheTime
                                              userInfo:userInfo]
                            flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                        if(value){
                            return [RACSignal just:value];
                        }else{
                            return [RACSignal empty];
                        }
                    }];
                }else{
                    return [RACSignal error:error];
                }
            }];
        }
            break;
        case NXNetCacheTypeFirstCache:{
            request = [
                [[[self _getCacheDataWithKey:key
                                   cacheTime:cacheTime
                                    userInfo:userInfo]
                  flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                    if(value){
                        return [RACSignal just:value];
                    }else{
                        return [RACSignal empty];
                    }
                }] onErrorResumeNext:^RACSignal * _Nonnull(NSError * _Nonnull error) {
                    return [[self POSTSignal:URLString
                                  parameters:parameters
                                     headers:headers
                                    progress:uploadProgress]
                            doNext:^(NXSessionDataTaskResult * _Nullable x) {
                        [self _cacheDataWithKey:key taskData:x];
                    }];
                }]
                concat:
                [[[self POSTSignal:URLString parameters:parameters
                          headers:headers
                         progress:uploadProgress]
                 doNext:^(NXSessionDataTaskResult * _Nullable x) {
                     [self _cacheDataWithKey:key taskData:x];
                 }] onErrorResumeNext:^RACSignal<NXSessionDataTaskResult *> * _Nonnull(NSError * _Nonnull error) {
                     //这里 没有java 的concatDeleayError  错误的时候先返回缓存,下游有延迟,或者没有网的情况会立即断整个流
                   return [[self _getCacheDataWithKey:key cacheTime:cacheTime userInfo:userInfo] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                       if(value){
                           return [RACSignal just:value];
                       }else{
                           return [RACSignal empty];
                       }
                   }];
                 }]
            ];
        }
            break;
        case NXNetCacheTypeIfCache:{
            request = [[[self _getCacheDataWithKey:key
                                         cacheTime:cacheTime
                                          userInfo:userInfo]
                        flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                if(value){
                    return [RACSignal just:value];
                }else{
                    //去获取网络
                    return [[self POSTSignal:URLString
                                  parameters:parameters
                                     headers:headers
                                    progress:uploadProgress]
                            doNext:^(NXSessionDataTaskResult * _Nullable x) {
                        [self _cacheDataWithKey:key taskData:x];
                    }];
                }
            }] onErrorResumeNext:^RACSignal * _Nonnull(NSError * _Nonnull error) {
                return [[self POSTSignal:URLString
                              parameters:parameters
                                 headers:headers
                                progress:uploadProgress]
                        doNext:^(NXSessionDataTaskResult * _Nullable x) {
                    [self _cacheDataWithKey:key taskData:x];
                }];
            }];
        }
            break;
        case NXNetCacheTypeOnlyCache:{
            request = [self _getCacheDataWithKey:key
                                       cacheTime:cacheTime
                                        userInfo:userInfo];
        }
            break;
        case NXNetCacheTypeOnlyRemote:{
            request= [[self POSTSignal:URLString
                            parameters:parameters
                               headers:headers
                              progress:uploadProgress]
                      doNext:^(NXSessionDataTaskResult * _Nullable x) {
                [self _cacheDataWithKey:key taskData:x];
            }];
        }
            break;
        default:{
            request= [[self POSTSignal:URLString
                            parameters:parameters
                               headers:headers
                              progress:uploadProgress]
                      doNext:^(NXSessionDataTaskResult * _Nullable x) {
                [self _cacheDataWithKey:key taskData:x];
            }];
        }
            break;
    }
    return request;
  
}



/**
 参考
 NSURLErrorDomain
 */
-(BOOL)_isNetConnectError:(NSError *)error{
    switch (error.code) {
        case NSURLErrorTimedOut:
            return YES;
            break;
        case NSURLErrorCannotFindHost:
            return YES;
            break;
        case NSURLErrorCannotConnectToHost:
            return YES;
            break;
        case NSURLErrorNetworkConnectionLost:
            return YES;
            break;
            
        case NSURLErrorDNSLookupFailed:
            return YES;
            break;
            
        case NSURLErrorNotConnectedToInternet:
            return YES;
            break;
            
        case NSURLErrorBadServerResponse:
            return YES;
            break;
    }
    return NO;
}

/**
 获取网络缓存
 */
- (RACSignal<NXSessionDataTaskResult *> *)_getCacheDataWithKey:(NSString *)key
                                                     cacheTime:(long long)cacheTime
                                                      userInfo:(NSDictionary *)userInfo{
    return [[RACSignal fromCallbck:^NXSessionDataTaskResult *_Nullable{
        YYDiskCache *diskCache=[NXNetCacheFactory.shared getCache:self.cacheConfigProvider];
        long long rawCacheTime=cacheTime;
        if(rawCacheTime<=0){
            rawCacheTime=self.cacheConfigProvider.cacheTime;
        }
        NSNumber *lastCachedTime=[NSNumber toKindOfClassObjectOrNilFrom:[diskCache objectForKey:[self _cacheTimeKeyWithKey:key]]];
        if(lastCachedTime&&(NSDate.now.milliseconds-lastCachedTime.longLongValue)<rawCacheTime){
            YYDiskCache *diskCache=[NXNetCacheFactory.shared getCache:self.cacheConfigProvider];
            id responseObject=[diskCache objectForKey:key];
            if(responseObject){
                NXSessionDataTaskResult *result=NXSessionDataTaskResult.new;
                NSMutableDictionary *mergeDict=userInfo.mutableCopyOrCast;
                [mergeDict setObject:@YES forKey:NXNetworkingTaskResponseIsCacheKey];
                result.userInfo=mergeDict;
                result.responseObject=responseObject;
                return result;
            }
        }
        //需要返回nil 不能返回[RACSignal empty]l
        return nil;
    }] subscribeOnSubThread:YES];
}

/**
 写入网络缓存
 */
-(void)_cacheDataWithKey:(NSString *)key taskData:(NXSessionDataTaskResult *)taskData{
    if(!self.cacheConfigProvider){
        return;
    }
    if(![self.cacheConfigProvider isCache:taskData]){
        return;
    }
    
    __block NXSessionDataTaskResult *rawTaskData=taskData;
    /**
     新开一个线程 避免阻塞真实http数据响应
     */
    [RACScheduler.scheduler schedule:^{
        YYDiskCache *diskCache=[NXNetCacheFactory.shared getCache:self.cacheConfigProvider];
        if(key&&rawTaskData.responseObject){
            //记录缓存内容
            [diskCache setObject:rawTaskData.responseObject forKey:key];
            //记录缓存时间
            [diskCache setObject:@(NSDate.now.milliseconds) forKey:[self _cacheTimeKeyWithKey:key]];
        }
    }];
}


-(NSString *)_cacheKeyWithURL:(NSString *)URLString
             parameters:(nullable id)parameters{
    //NSAssert([parameters isKindOfClass:NSObject.class], @"http param 参数不正确");
    NSString *combinedStr=[URLString stringByAppendingString:safeStr(((NSObject *)parameters).yy_modelToJSONString)];
    return combinedStr.nx_md5;
}

-(NSString *)_cacheTimeKeyWithKey:(NSString *)key{
    return [NSString stringWithFormat:@"%@_cacheTimeRecord",key];
}

@end
