//
//  NXNewInstanceHandler.h
//  Pods
//
//  Created by XXF on 2022/9/27.
//
/**
 @param url 路由
 @parameters 参数与配置
 */
typedef id (^NXRouterInstanceFactory)(NSString *url,NSDictionary *parameters);
