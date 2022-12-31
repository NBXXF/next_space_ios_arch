//
//  XXF.m
//  AFNetworking
//
//  Created by XXF on 2022/8/24.
//

#import "XXF.h"
#import <MMKV/MMKV.h>
#import <Watchdog/Watchdog-umbrella.h>
#import <Watchdog/Watchdog-Swift.h>


@implementation XXF
static NXPTConvertBlock __ptConvertBlock;
static NXUserIdProvider __userIdProvider;
static NXAppGroupNameProvider __appGroupNameProvider;
static Watchdog *__watchdog;

+ (void)initWithConfig:(NXPTConvertBlock)ptConvertBlock appGroupNameProvider:(NXAppGroupNameProvider)appGroupNameProvider userIdProvider:(NXUserIdProvider)userIdProvider performance:(CGFloat (^)(void))performanceBlock{
    __ptConvertBlock=ptConvertBlock;
    __appGroupNameProvider=appGroupNameProvider;
    __userIdProvider=userIdProvider;
    [self _initMMKV];
    [self _initPerformanceMonitor:performanceBlock()];
}



+(void)_initMMKV{
    NSString *myGroupID = self.getAppGroupName;
    if(!myGroupID || myGroupID.length==0){
        [MMKV initializeMMKV:nil logLevel:MMKVLogDebug];
    }else{
        NSString *groupDir = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:myGroupID].path;
        if(!groupDir){
            @throw [NSException exceptionWithName:@"初始化失败" reason:@"groupName 错误" userInfo:nil];
        }
        [MMKV initializeMMKV:nil groupDir:groupDir logLevel:MMKVLogDebug];
    }
}


+(void)_initPerformanceMonitor:(CGFloat)threshold{
    if(threshold<=0||threshold>=CGFLOAT_MAX){
        return;
    }
    __watchdog=[[Watchdog alloc] initWithThreshold:threshold strictMode:YES];
}

+ (CGFloat)convertPTFromPX:(CGFloat)value{
    if(!__ptConvertBlock){
        @throw [NSException exceptionWithName:@"初始化失败" reason:@"请初始化xxf" userInfo:nil];
    }
    return __ptConvertBlock(value);
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
@end
