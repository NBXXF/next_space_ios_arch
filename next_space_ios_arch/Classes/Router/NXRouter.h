//
//  NXRouter.h
//  AFNetworking
//
//  Created by XXF on 2022/9/27.
//

#import <Foundation/Foundation.h>
#import "NXRouterResultCallback.h"
#import "NXRouterHandlerBlock.h"
#import "NXRouterInstanceFactory.h"
#import <JLRoutes/JLRoutes.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const NXRouterResultCallbackKey;
extern NSString *const NXRouterClassNameKey;

@interface NXRouter : NSObject

+ (void)initRouter:(UIApplication *)application routerHandler:(NXRouterHandlerBlock)handler andInstanceFactory:(NXRouterInstanceFactory)instanceFactory;


/**
 调用 Router
 @param url 路由,暂时不支持本身携带的query参数自动解析
 */
+ (BOOL)openURL:(NSString *)url;


/**
 调用 Router
 @param url 路由,暂时不支持本身携带的query参数自动解析
 @param parameters  路由携带的参数
 */
+ (BOOL)openURL:(NSString *)url parameters:(NSDictionary * __nullable)parameters;


/**
 调用 Router
 @param url 路由,暂时不支持本身携带的query参数自动解析
 @param parameters  路由携带的参数
 @param callback  回调响应参数
 */
+ (BOOL)openURL:(NSString *)url parameters:(NSDictionary * __nullable)parameters resultCallback:(NXRouterResultCallback __nullable)callback;


/**
 注册路由【在对应的类的+load 方法去注册】 默认注册手机的vc
 @param url 路由,暂时不支持本身携带的query参数自动解析
 @param target 目的地的class  和url 一一映射
 */
+ (void)registerURL:(NSString* )url targetClass:(Class)target;


/**
 注册路由【在对应的类的+load 方法去注册】
 @param url 路由,暂时不支持本身携带的query参数自动解析
 @param target 目的地的class  和url 一一映射
 @param device  区分不同设备形态,默认手机  
 @param config  静态注册的参数配置,框架 会和openURL 携带的参数进行合并,携带的参数key 优先级最高,等价【getAdjustURLConfig】
 @param handler  注册路由处理跳转,一般情况下传递空,否则自己处理
 */
+ (void)registerURL:(NSString* )url targetClass:(Class)target deviceType:(UIUserInterfaceIdiom)device config:(NSDictionary * __nullable)config handler:(NXRouterHandlerBlock __nullable) handler;


/**
 注册SPI 建议在类的load 方法中注册
 @param api 定义的暴露服务
 @param target 目标类
 */
+(void)registerService:(Protocol *)api targetClass:(Class)target;

/**
 注册SPI 建议在类的load 方法中注册
 @param api 定义的暴露服务
 @param target 目标类
 @param priority   优先级 From large to small  目前只针对NXInitializer 有效
 */
+ (void)registerService:(Protocol *)api targetClass:(Class)target priority:(NSNumber *)priority;


/**
 获取SPI实例
 @param api 定义的暴露服务
 */
+(id)getService:(Protocol *)api;

/**
 获取SPI 对应的所有实例
 @param api 定义的暴露服务
 */
+(NSArray<id> *)getServices:(Protocol *)api;



/**
 获取全局的路由处理器,方便业务包装
 */
+(NXRouterHandlerBlock)getGlobalRouterHandlerBlock;


/**
 获取适配的Config
 */
+(NSDictionary *)getAdjustURLConfig:(NSString* )url;


/**
 获取构建实例的工厂
 */
+(NXRouterInstanceFactory)getInstanceFactory;


/**
 注入实例对应的参数
 */
+(void)autoInjectParams:(id)instance parameters:(NSDictionary * __nullable)parameters;

@end

NS_ASSUME_NONNULL_END
