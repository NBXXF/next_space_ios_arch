//
//  JLRRouteDefinition+NXHook.m
//  AFNetworking
//  hook 合并净态配置参数    且回调为NSMutable的字典 业务可以修改
//  Created by XXF on 2022/12/29.
//

#import "JLRRouteDefinition+NXHook.h"
#import <next_space_ios_arch/NXRouter.h>
#import <next_space_ios_arch/NSObject+ExchangeMethod.h>


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
    //且回调为NSMutable的字典 业务可以修改
    return [self _callHandlerBlockWithParameters:configDict];
}
@end
