//
//  JLRRouteDefinition+NXHook.m
//  AFNetworking
//  hook 合并静态配置参数 
//  Created by XXF on 2022/12/29.
//

#import "JLRRouteDefinition+NXHook.h"
#import <next_space_ios_arch/NXRouter.h>
#import <next_space_ios_arch/NSObject+Swizzling.h>


@implementation JLRRouteDefinition(NXHook)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject exchangeInstanceMethodWithSelfClass:JLRRouteDefinition.class
                                     originalSelector:@selector(callHandlerBlockWithParameters:)                     swizzledSelector:@selector(_callHandlerBlockWithParameters:)];
    });
}
/**
 替换这个方法
 */
- (BOOL)_callHandlerBlockWithParameters:(NSDictionary *)parameters{
    //进行静态参数和动态参数合并
    NSString *url=[parameters[JLRouteURLKey] absoluteString];
    NSMutableDictionary *configDict=[NXRouter getAdjustURLConfig:url].mutableCopy;
    if(!configDict){
        configDict=[NSMutableDictionary dictionary];
    }
    if(parameters){
        [configDict addEntriesFromDictionary:parameters];
    }
    return [self _callHandlerBlockWithParameters:configDict];
}
@end
