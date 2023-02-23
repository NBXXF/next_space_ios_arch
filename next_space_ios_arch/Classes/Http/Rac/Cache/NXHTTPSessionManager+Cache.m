//
//  NXHTTPSessionManager+Cache.m
//  AFNetworking
//
//  Created by 1234 on 2023/2/23.
//

#import "NXHTTPSessionManager+Cache.h"
#import <YYModel/YYModel.h>
#import <next_space_ios_arch/NSString+NXUtil.h>
#import <next_space_ios_arch/StringUtils.h>
#import <next_space_ios_arch/RACSignal+AppArch.h>

@implementation NXHTTPSessionManager(Cache)
- (RACSignal<NXSessionDataTaskResult *> *)GETSignal:(NSString *)URLString
                   parameters:(nullable id)parameters
                      headers:(nullable NSDictionary <NSString *, NSString *> *)headers
                         progress:(nullable void (^)(NSProgress * _Nonnull))downloadProgress cacheType:(NXNetCacheType)cacheType
                                          cacheTime:(NSTimeInterval)cacheTime{
    
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
    switch (cacheType) {
        case NXNetCacheTypeFirstRemote:{
            request= [[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress] onErrorResumeNext:^RACSignal<NXSessionDataTaskResult *> * _Nonnull(NSError * _Nonnull error) {
                return [[self getCacheByKey:[self cacheKeyWithURL:URLString parameters:parameters]] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                    if(value){
                        return [RACSignal just:value];
                    }else{
                        return [RACSignal empty];
                    }
                }];
            }];
        }
            break;
        case NXNetCacheTypeFirstCache:{
            request = [[[self getCacheByKey:[self cacheKeyWithURL:URLString parameters:parameters]] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                if(value){
                    return [RACSignal just:value];
                }else{
                    return [RACSignal empty];
                }
            }] concat:[self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress]];
        }
            break;
        case NXNetCacheTypeIfCache:{
            request = [[[self getCacheByKey:[self cacheKeyWithURL:URLString parameters:parameters]] flattenMap:^__kindof RACSignal * _Nullable(NXSessionDataTaskResult * _Nullable value) {
                if(value){
                    return [RACSignal just:value];
                }else{
                    //去获取网络
                    return [self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress];
                }
            }] onErrorResumeNext:^RACSignal * _Nonnull(NSError * _Nonnull error) {
                return [self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress];
            }];
        }
            break;
        case NXNetCacheTypeOnlyCache:{
            request = [self getCacheByKey:[self cacheKeyWithURL:URLString parameters:parameters]];
        }
            break;
        case NXNetCacheTypeOnlyRemote:{
            request= [self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress];
        }
            break;
        default:{
            request= [self GETSignal:URLString parameters:parameters headers:headers progress:downloadProgress];
        }
            break;
    }
    return request;
}

- (RACSignal<NXSessionDataTaskResult *> *)getCacheByKey:(NSString *)key{
    return [RACSignal fromCallbck:^NXSessionDataTaskResult *_Nullable{
        return nil;
    }];
}


-(NSString *)cacheKeyWithURL:(NSString *)URLString
             parameters:(nullable id)parameters{
    NSAssert([parameters isKindOfClass:NSObject.class], @"http param 参数不正确");
    NSString *combinedStr=[URLString stringByAppendingString:safeStr(((NSObject *)parameters).yy_modelToJSONString)];
    return combinedStr.nx_md5;
}

@end
