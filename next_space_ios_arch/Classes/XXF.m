//
//  XXF.m
//  AFNetworking
//
//  Created by XXF on 2022/8/24.
//

#import "XXF.h"
#import <MMKV/MMKV.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>
#import <UIScreen+NXTools.h>
#import <objc/runtime.h>

@interface XXF()

@end

@implementation XXF



static NXUserIdProvider __userIdProvider;
static NXAppGroupNameProvider __appGroupNameProvider;
static BlockWatcher *__watchdog;


+ (XXF *)shared{
    static XXF *service=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc]init];
    });
    return service;
}



+ (void)initWithConfig:(NXAppGroupNameProvider)appGroupNameProvider userIdProvider:(NXUserIdProvider)userIdProvider{
    [self initWithConfig:appGroupNameProvider
          userIdProvider:userIdProvider
            configOption:XXFConfigOption.new];
}

+ (void)initWithConfig:(NXAppGroupNameProvider)appGroupNameProvider userIdProvider:(NXUserIdProvider)userIdProvider
          configOption:(XXFConfigOption *)option{
    __appGroupNameProvider=appGroupNameProvider;
    __userIdProvider=userIdProvider;
    XXF.shared.config=option;
    [self _initMMKV];
    [self _initPerformanceMonitor];
}


+(void)_initMMKV{
    NSString *myGroupID = self.getAppGroupName;
    if(!myGroupID || myGroupID.length==0){
#if DEBUG
        [MMKV initializeMMKV:nil logLevel:MMKVLogDebug];
#else
        [MMKV initializeMMKV:nil logLevel: MMKVLogNone];
#endif
    }else{
        NSString *groupDir = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:myGroupID].path;
        if(!groupDir){
            @throw [NSException exceptionWithName:@"初始化失败" reason:@"groupName 错误" userInfo:nil];
        }
#if DEBUG
        [MMKV initializeMMKV:nil groupDir:groupDir logLevel:MMKVLogDebug];
#else
        [MMKV initializeMMKV:nil groupDir:groupDir logLevel:MMKVLogNone];
#endif
    }
}



+ (CGFloat)convertPTFromPX:(CGFloat)value{
    return [UIScreen.mainScreen getDensityValue:value];
}


+ (NSString *)getUserId{
    if(!__userIdProvider){
        @throw [NSException exceptionWithName:@"初始化失败" reason:@"请初始化xxf" userInfo:nil];
    }
    return __userIdProvider();
}

+ (NSString *)getAppGroupName{
    if(!__appGroupNameProvider){
        @throw [NSException exceptionWithName:@"初始化失败" reason:@"请初始化xxf" userInfo:nil];
    }
    return __appGroupNameProvider();
}


+ (void)_initPerformanceMonitor{
#if DEBUG
    //业务可以选择unlock方式修改 短暂解决临时不变
    CGFloat threshold=0.4;
    if(!__watchdog){
        //单位是s 秒
        __watchdog=[[BlockWatcher alloc] initWithThreshold:threshold strictMode:YES];
    }
#endif
}


+ (void)startPerformanceMonitor:(CGFloat)threshold{
    NSLog(@"***********无效api#startPerformanceMonitor 已经框架自动处理了");
}

@end
