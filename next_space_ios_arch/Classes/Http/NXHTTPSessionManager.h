//
//  NXHTTPSessionManager.h
//  NXHTTP
//  解决AFN下载bug 并进行拓展
//  Created by XXF on 2022/11/9.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "NXHttpInterceptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface NXHTTPSessionManager : AFHTTPSessionManager

/**
 添加拦截器
 */
-(void)addInterceptor:(NXHttpInterceptor *)interceptor;


/**
 移除拦截器
 */
-(void)removeInterceptor:(NXHttpInterceptor *)interceptor;


@end

NS_ASSUME_NONNULL_END
