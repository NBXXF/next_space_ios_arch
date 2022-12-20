//
//  Singleton.h
//  Pods
/**
 简化单例 宏定义
 
 
 用法两步
 1 .h文件
 singleton_interface(NXImportService)
 2 .m文件
 singleton_implementation(NXImportService)
 
 */
//  Created by XXF on 2022/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// .h
#define singleton_interface(class) + (instancetype)shared;

// .m
#define singleton_implementation(class) \
static class *_instance; \
+ (instancetype)shared \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[class alloc] init]; \
}); \
\
return _instance; \
}\

NS_ASSUME_NONNULL_END
