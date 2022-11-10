//
//  NXHTTPSessionManager.m
//  NXHTTP
//  解决AFN下载bug 并进行拓展
//  Created by XXF on 2022/11/9.
//

#import "NXHTTPSessionManager.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface NXHTTPSessionManager()
@property(nonatomic,strong) NSMutableArray<NXHttpInterceptor *> *interceptorArray;
@end
@implementation NXHTTPSessionManager
- (instancetype)init{
    self=[super init];
    if(self){
        //默认监听任务完成
        [self setTaskDidCompleteBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSError * _Nullable error) {
            
        }];
    }
    return self;
    return [super init];
}


//这里包装完成拦截
- (void)setTaskDidCompleteBlock:(void (^)(NSURLSession * _Nonnull, NSURLSessionTask * _Nonnull, NSError * _Nullable))block{
    @weakify(self);
    [super setTaskDidCompleteBlock:^(NSURLSession * _Nonnull session, NSURLSessionTask * _Nonnull task, NSError * _Nullable error) {
        @strongify(self)
        [self dispatchInterceptorWithResponse:task error:error];
    }];
}


- (NSMutableArray *)interceptorArray{
    if(!_interceptorArray){
        _interceptorArray=[NSMutableArray array];
    }
    return _interceptorArray;
}


- (void)addInterceptor:(NXHttpInterceptor *)interceptor{
    if(interceptor){
        [self.interceptorArray removeObject:interceptor];
        [self.interceptorArray addObject:interceptor];
    }
}

- (void)removeInterceptor:(NXHttpInterceptor *)interceptor{
    if(interceptor){
        [self.interceptorArray removeObject:interceptor];
    }
}

/**
 调度拦截器
 */
-(NSURLRequest *)dispatchInterceptorWithRequest:(NSURLRequest *)request{
    __block NSURLRequest *result=request;
    [self.interceptorArray enumerateObjectsUsingBlock:^(NXHttpInterceptor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        result=[obj interceptRequest:result];
    }];
    return result;
}

/**
 调度拦截器
 */
-(void)dispatchInterceptorWithResponse:(NSURLSessionTask * _Nonnull) task error:(NSError * _Nullable) error{
    [self.interceptorArray enumerateObjectsUsingBlock:^(NXHttpInterceptor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj interceptResponse:task error:error];
    }];
}


//========================【下面是拦击afn本身方法】=====================

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method URLString:(NSString *)URLString parameters:(id)parameters headers:(NSDictionary<NSString *,NSString *> *)headers uploadProgress:(void (^)(NSProgress * _Nonnull))uploadProgress downloadProgress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    request.allHTTPHeaderFields=headers;
    request.HTTPMethod=method;
    
    //分发到拦截器
    NSURLRequest *newRequest= [self dispatchInterceptorWithRequest:request];
    
    
    
    return [super dataTaskWithHTTPMethod:newRequest.HTTPMethod URLString:newRequest.URL.absoluteString parameters:parameters headers:newRequest.allHTTPHeaderFields uploadProgress:uploadProgress downloadProgress:downloadProgress success:success failure:failure];
}



//================>上传相关API
- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request progress:(void (^)(NSProgress * _Nonnull))uploadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler{
    
    //分发到拦截器
    NSURLRequest *newRequest= [self dispatchInterceptorWithRequest:request];
    
    return [super uploadTaskWithStreamedRequest:newRequest progress:uploadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData progress:(void (^)(NSProgress * _Nonnull))uploadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler{
    
    //分发到拦截器
    NSURLRequest *newRequest= [self dispatchInterceptorWithRequest:request];
    
    return [super uploadTaskWithRequest:newRequest fromData:bodyData progress:uploadProgressBlock completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL progress:(void (^)(NSProgress * _Nonnull))uploadProgressBlock completionHandler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))completionHandler{
    
    //分发到拦截器
    NSURLRequest *newRequest= [self dispatchInterceptorWithRequest:request];
    
    return [super uploadTaskWithRequest:newRequest fromFile:fileURL progress:uploadProgressBlock completionHandler:completionHandler];
}




//=================>下载相关
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request progress:(void (^)(NSProgress * _Nonnull))downloadProgressBlock destination:(NSURL * _Nonnull (^)(NSURL * _Nonnull, NSURLResponse * _Nonnull))destination completionHandler:(void (^)(NSURLResponse * _Nonnull, NSURL * _Nullable, NSError * _Nullable))completionHandler{
    
    //分发到拦截器
    //分发到拦截器
    NSURLRequest *newRequest= [self dispatchInterceptorWithRequest:request];
    
    return [super downloadTaskWithRequest:newRequest progress:downloadProgressBlock destination:destination completionHandler:completionHandler];
}



/**
 处理下载非200的情况
 */
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    //默认非200 下载框架也是执行下载的,这里解决这个问题
    if([downloadTask.response isKindOfClass:NSHTTPURLResponse.class]){
        NSHTTPURLResponse *urlResponse=(NSHTTPURLResponse *)downloadTask.response;
        NSInteger code=urlResponse.statusCode;
        if(code!=200){
            [[NSNotificationCenter defaultCenter] postNotificationName:AFURLSessionDownloadTaskDidFailToMoveFileNotification object:downloadTask userInfo: @{
                NSLocalizedDescriptionKey:@"下载失败",
                NSLocalizedFailureReasonErrorKey:[NSString stringWithFormat:@"code:%ld %@",(long)code,urlResponse.description],
                NSLocalizedRecoverySuggestionErrorKey:@"意见：请联系接口定义人"
                }];
            return;
        }
    }
    //再执行父类方法
    [super URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
}
@end
