//
//  XXF.m
//  AFNetworking
//
//  Created by XXF on 2022/8/24.
//

#import "XXF.h"
#import <MMKV/MMKV.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>


@implementation XXF
static NXPTConvertBlock __ptConvertBlock;
static NXUserIdProvider __userIdProvider;
static NXAppGroupNameProvider __appGroupNameProvider;
static BlockWatcher *__watchdog;

+ (void)initWithConfig:(NXPTConvertBlock)ptConvertBlock appGroupNameProvider:(NXAppGroupNameProvider)appGroupNameProvider userIdProvider:(NXUserIdProvider)userIdProvider{
    __ptConvertBlock=ptConvertBlock;
    __appGroupNameProvider=appGroupNameProvider;
    __userIdProvider=userIdProvider;
    [self _initMMKV];
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


+ (void)startPerformanceMonitor:(CGFloat)threshold{
    NSAssert(threshold>0, @"threshold 必须大于0");
    if(!__watchdog){
        __watchdog=[[BlockWatcher alloc] initWithThreshold:threshold strictMode:YES];
    }
}

@end
