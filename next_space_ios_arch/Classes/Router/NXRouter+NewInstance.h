//
//  NXRouter+NewInstance.h
//  AppArch
//
//  Created by XXF on 2022/9/28.
//

#import <Foundation/Foundation.h>
#import "NXRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface NXRouter(NewInstance)
+ (UIViewController * __nullable)viewControllerWithRouteURL:(NSString *)routeURL parameters:(NSDictionary * _Nullable )parameters DEPRECATED_MSG_ATTRIBUTE("过时,避免业务乱用,请优先用路由,要相信SPI的设计");


/**
 与openURL的区别
 内部自动会处理是否是主线程跳转
 缺点没有返回值
 */
+ (void)startURL:(NSString *)url;


/**
 与openURL的区别
 内部自动会处理是否是主线程跳转
 缺点没有返回值
 */
+ (void)startURL:(NSString *)url parameters:(NSDictionary * __nullable)parameters;


/**
 与openURL的区别
 内部自动会处理是否是主线程跳转
 缺点没有返回值
 */
+ (void)startURL:(NSString *)url parameters:(NSDictionary * __nullable)parameters resultCallback:(NXRouterResultCallback __nullable)callback;

@end

NS_ASSUME_NONNULL_END
