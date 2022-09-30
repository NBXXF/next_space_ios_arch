//
//  NXRouter.m
//   新的路由框架,算基础框架的部分 其他人勿动,请联系XXF
//  Created by XXF on 2022/9/27.
//

#import "NXRouter.h"
#import <JLRoutes/JLRoutes.h>
#import <JLRoutes/JLRRouteDefinition.h>
#import "NXVCRouterConst.h"
#import "NXServiceLoader.h"
#import "NXInitializer.h"

NSString *const NXRouterResultCallbackKey = @"kRouterResultCallback";
NSString *const NXRouterClassNameKey = @"kRouterClassName";

static NSMutableDictionary<NSString *,NSDictionary<NSNumber *,NSDictionary *> *> *globalStaticConfig;

static NXRouterHandlerBlock globalHandlerBlock;
static NXRouterInstanceFactory globalInstanceFactory;
/**
  新的路由框架,算基础框架的部分 其他人勿动,请联系XXF
 */
@implementation NXRouter
+ (void)initialize{
    globalStaticConfig=[NSMutableDictionary dictionary];
}

+ (void)initRouter:(UIApplication *)application routerHandler:(NXRouterHandlerBlock)handler andInstanceFactory:(NXRouterInstanceFactory)instanceFactory
{
    globalHandlerBlock=handler;
    globalInstanceFactory=instanceFactory;
    
    NSArray<id<NXInitializer>> *initializerArray= [NXServiceLoader getServices:@protocol(NXInitializer)];
    [initializerArray sortedArrayUsingComparator:^NSComparisonResult(id<NXInitializer> _Nonnull obj1, id<NXInitializer>  _Nonnull obj2) {
        return [obj2.priority compare:obj1.priority];
    }];
    [initializerArray enumerateObjectsUsingBlock:^(id<NXInitializer>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj application:application];
    }];
}


+ (BOOL)openURL:(NSString *)url{
    return [self openURL:url parameters:[NSDictionary dictionary]];
}


+ (BOOL)openURL:(NSString *)url parameters:(NSDictionary *)parameters{
    return [self openURL:url parameters:parameters resultCallback:nil];
}


+ (BOOL)openURL:(NSString *)url parameters:(NSDictionary *)parameters resultCallback:(NXRouterResultCallback)callback{
    if([[NSThread currentThread] isMainThread]){
        return [JLRoutes routeURL:[NSURL URLWithString:url] withParameters:[self wrapperCallBack:url parameters:parameters resultCallback:callback]];
    }else{
        return NO;
    }
}

/**
 将callback 包装成参数
 注意优先级 应该先全局 再合并动态传递的
 */
+(NSDictionary *)wrapperCallBack:(NSString *)url parameters:(NSDictionary *__nullable)parameters resultCallback:(NXRouterResultCallback)callback{
    NSMutableDictionary *mergeDic= [NSMutableDictionary dictionary];
    //第一步 将静态配置的参数解析出来
    NSDictionary *deviceStaticConfigByUrl=[self getAdjustURLConfig:url];
    if(deviceStaticConfigByUrl){
        [mergeDic addEntriesFromDictionary:deviceStaticConfigByUrl];
    }
    //第二步 将当前动态传递的参数进行合并
    if(parameters){
        [mergeDic addEntriesFromDictionary:parameters];
    }
    //第三步 将callback 传递到参数里面
    if(callback){
        [mergeDic setObject:callback forKey:NXRouterResultCallbackKey];
    }
    return mergeDic;
}



+ (void)registerURL:(NSString *)url targetClass:(Class)target{
    [self registerURL:url targetClass:target deviceType:UIUserInterfaceIdiomPhone config:[NSDictionary dictionary] handler:nil];
}


+ (void)registerURL:(NSString *)url targetClass:(Class)target deviceType:(UIUserInterfaceIdiom)device config:(NSDictionary *)config handler:(NXRouterHandlerBlock)handler{
    if(!config){
        config=[NSDictionary dictionary];
    }
    
    
    //获取url 对应的config
    NSMutableDictionary *staticConfigByUrl= ([globalStaticConfig objectForKey:url]?:[NSDictionary dictionary]).mutableCopy;
    
    //获取url 对应的设备(手机/pad等)的config
    NSMutableDictionary *deviceStaticConfigByUrl= ((NSDictionary *)[staticConfigByUrl objectForKey:@(device)]?:[NSDictionary dictionary]).mutableCopy;
    //存储class 名字
    [deviceStaticConfigByUrl setObject:NSStringFromClass(target) forKey:NXRouterClassNameKey];
    
    //将注册配置添加到里面
    [deviceStaticConfigByUrl addEntriesFromDictionary:config];
    
    //保存url 对应的设备(手机/pad等)的config
    [staticConfigByUrl setObject:deviceStaticConfigByUrl forKey:@(device)];
    
    //保存到全局配置里面
    [globalStaticConfig setObject:staticConfigByUrl forKey:url];
    
    [JLRoutes.globalRoutes addRoute:url handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        if(handler){
            return handler(parameters);
        }else if(globalHandlerBlock){
            return globalHandlerBlock(parameters);
        }
        return NO;
    }];
}


+ (void)registerService:(Protocol *)api targetClass:(Class)target{
    [NXServiceLoader registerService:api targetClass:target priority:@(0)];
}

+ (void)registerService:(Protocol *)api targetClass:(Class)target priority:(NSNumber *)priority{
    [NXServiceLoader registerService:api targetClass:target priority:priority];
}

+ (id)getService:(Protocol *)api{
    return [NXServiceLoader getService:api];
}

+ (NSArray<id> *)getServices:(Protocol *)api{
    return [NXServiceLoader getServices:api];
}


+ (NXRouterHandlerBlock)getGlobalRouterHandlerBlock{
    return globalHandlerBlock;
}



+ (NSDictionary *)getAdjustURLConfig:(NSString *)url{
    UIUserInterfaceIdiom device = [[UIDevice currentDevice] userInterfaceIdiom];
    //获取url 对应的config
    NSDictionary *staticConfigByUrl= [globalStaticConfig objectForKey:url]?:[NSDictionary dictionary];
    
    //获取url 对应的设备(手机/pad等)的config
    NSObject *deviceStaticConfigByUrl=[staticConfigByUrl objectForKey:@(device)];
    if([deviceStaticConfigByUrl isKindOfClass:NSDictionary.class]){
        return ((NSDictionary *)deviceStaticConfigByUrl).copy;
    }
    
    //找不到对应类型的设备注册  就默认用手机的
    device = UIUserInterfaceIdiomPhone;
    staticConfigByUrl= [globalStaticConfig objectForKey:url]?:[NSDictionary dictionary];
    deviceStaticConfigByUrl=[staticConfigByUrl objectForKey:@(device)];
    if([deviceStaticConfigByUrl isKindOfClass:NSDictionary.class]){
        return ((NSDictionary *)deviceStaticConfigByUrl).copy;
    }
    return [NSDictionary dictionary];
}

+ (NXRouterInstanceFactory)getInstanceFactory{
    return globalInstanceFactory;
}

+ (void)autoInjectParams:(id)instance parameters:(NSDictionary *)parameters{
    if(instance&&parameters){
        for (NSString *key in parameters.allKeys) {
            //值为nil 要崩
            if([instance respondsToSelector:NSSelectorFromString(key)] && parameters[key]){
                @try {
                    //TODO 类型问题 需要解决 一一对应,否则业务容易引起bug
                    [instance setValue:parameters[key] forKey:key];
                } @catch (NSException *exception) {
                }
            }
        }
        //注意不能随便改
        NSString *keyInnerParams=@"routerParams";
        //附加整个参数到vc里面,业务可以自己解析
        if([instance respondsToSelector:NSSelectorFromString(keyInnerParams)]){
            @try {
                [instance setValue:parameters forKey:keyInnerParams];
            } @catch (NSException *exception) {
            }
        }
    }
}
@end
