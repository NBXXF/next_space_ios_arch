//
//  NXServiceLoader.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXServiceLoader : NSObject

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


@end

NS_ASSUME_NONNULL_END
