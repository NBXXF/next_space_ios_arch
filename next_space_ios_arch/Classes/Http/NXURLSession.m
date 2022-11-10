//
//  NXURLSession.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/10.
//

#import "NXURLSession.h"

@implementation NXURLSession

//下载相关
- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super downloadTaskWithRequest:request];
}

- (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super downloadTaskWithRequest:request completionHandler:completionHandler];
}

//常规http
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super dataTaskWithRequest:request];
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super dataTaskWithRequest:request completionHandler:completionHandler];
}



//上传相关

- (NSURLSessionUploadTask *)uploadTaskWithStreamedRequest:(NSURLRequest *)request{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super uploadTaskWithStreamedRequest:request];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super uploadTaskWithRequest:request fromData:bodyData];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super uploadTaskWithRequest:request fromFile:fileURL];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromData:(NSData *)bodyData completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super uploadTaskWithRequest:request fromData:bodyData completionHandler:completionHandler];
}

- (NSURLSessionUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler{
    NSLog(@"=============>执行:%@ %s",request.URL,__func__);
    return [super uploadTaskWithRequest:request fromFile:fileURL completionHandler:completionHandler];
}

@end
