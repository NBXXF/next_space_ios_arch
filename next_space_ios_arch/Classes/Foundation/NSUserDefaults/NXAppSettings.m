//
//  NXAppSettings.m
//  next_space_ios_arch
//  配置全局的设置,业务请注意适度,比如数据量太大,或者频繁访问 请注意性能问题
//  用法:业务在此类的基础上写分类
//  Created by XXF on 2022/11/28.
//

#import "NXAppSettings.h"
#import "NXKeyValueService.h"

@implementation NXAppSettings
+ (NXAppSettings *)shared{
    static NXAppSettings *service=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc]init];
    });
    return service;
}

- (id<NXKeyValueServiceProtocal>)keyValueSrvice{
    return NXKeyValueService.shared;
}

@end
