//
//  NXHttpInterceptor.m
//  AFNetworking
//  网络拦截器
//  Created by XXF on 2022/11/10.
//

#import "NXHttpInterceptor.h"

@implementation NXHttpInterceptor


- (NSURLRequest *)interceptRequest:(NSURLRequest *)request{
    
    /**
     常见用法 示意如下
     */
//    NSMutableURLRequest *newRequest=request.mutableCopy;
//    newRequest.xxxx=xxx;
//    return newRequest.copy;
    
    return request;
}
@end
