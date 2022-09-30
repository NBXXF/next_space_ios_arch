//
//  NXServiceLoader.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/9/30.
//

#import "NXServiceLoader.h"
#import "NXRouterServiceDefinition.h"
#import "NXInitializer.h"

static NSMutableDictionary<NSString *,NSMutableArray<NXRouterServiceDefinition *> *> *spiRegisterTable;
@implementation NXServiceLoader


+ (void)initialize{
    spiRegisterTable=[NSMutableDictionary dictionary];
}


+ (void)registerService:(Protocol *)api targetClass:(Class)target{
    [self registerService:api targetClass:target priority:@(0)];
}



+ (void)registerService:(Protocol *)api targetClass:(Class)target priority:(NSNumber *)priority{
    NSString *apiProtocolName= NSStringFromProtocol(api);
    NSString *targetClassName= NSStringFromClass(target);
    if(![target conformsToProtocol:api]){
        NSString *reason=[NSString stringWithFormat:@"%@ not conformsToProtocol %@",targetClassName,apiProtocolName];
        NSException *e = [NSException
                          exceptionWithName: @"ServiceRegisterException"
                          reason: reason
                          userInfo: nil];
        @throw e;
    }
    NXRouterServiceDefinition *definition=[[NXRouterServiceDefinition alloc] init];
    definition.apiProtocolName=apiProtocolName;
    definition.targetClassName=targetClassName;
    
    NSMutableArray<NXRouterServiceDefinition *> *apiServiceArray=  (NSMutableArray<NXRouterServiceDefinition *> *)[spiRegisterTable objectForKey:apiProtocolName]?:[NSMutableArray array];
    
    //插入首位 后面注册优先
    [apiServiceArray insertObject:definition atIndex:0];
    
    [spiRegisterTable setObject:apiServiceArray forKey:apiProtocolName];
}


+ (id)getService:(Protocol *)api{
    NSString *providerProtocolName= NSStringFromProtocol(api);
    NSMutableArray<NXRouterServiceDefinition *> *apiServiceArray=  (NSMutableArray<NXRouterServiceDefinition *> *)[spiRegisterTable objectForKey:providerProtocolName]?:[NSMutableArray array];
    NXRouterServiceDefinition *definition=apiServiceArray.firstObject;
    if(!definition){
        NSString *reason=[NSString stringWithFormat:@"%@ not register",providerProtocolName];
        NSException *e = [NSException
                                 exceptionWithName: @"ServiceRegisterException"
                          reason: reason
                                 userInfo: nil];
        @throw e;
    }
    if(!definition.target){
        NSString *targetClassName=definition.targetClassName;
        definition.target=[[NSClassFromString(targetClassName) alloc] init];
    }
    return definition.target;
}



+ (NSArray<id> *)getServices:(Protocol *)api{
    NSString *apiProtocolName= NSStringFromProtocol(api);
    NSMutableArray<NXRouterServiceDefinition *> *apiServiceArray=  (NSMutableArray<NXRouterServiceDefinition *> *)[spiRegisterTable objectForKey:apiProtocolName]?:[NSMutableArray array];
    NSMutableArray<id> *resultArray=[NSMutableArray array];
    [apiServiceArray enumerateObjectsUsingBlock:^(NXRouterServiceDefinition * _Nonnull definition, NSUInteger idx, BOOL * _Nonnull stop) {
        if(!definition.target){
            NSString *targetClassName=definition.targetClassName;
            definition.target=[[NSClassFromString(targetClassName) alloc] init];
        }
        [resultArray addObject:definition.target];
    }];
    return resultArray;
}

@end
