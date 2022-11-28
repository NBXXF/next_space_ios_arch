//
//  NXAppSettings.h
//  next_space_ios_arch
//  配置全局的设置,业务请注意适度,比如数据量太大,或者频繁访问 请注意性能问题
//  用法:业务在此类的基础上写分类
//  Created by XXF on 2022/11/28.
//

#import <Foundation/Foundation.h>
#import "NXKeyValueServiceProtocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface NXAppSettings : NSObject
@property (class, readonly, strong) NXAppSettings *shared;
@property(strong,readonly) id<NXKeyValueServiceProtocal> keyValueSrvice;
@end

NS_ASSUME_NONNULL_END
