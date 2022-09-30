//
//  NXRouterDefinition.h
//  next_space_ios_arch
//  spi 注册配置
//  Created by XXF on 2022/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXRouterServiceDefinition : NSObject<NSCopying>
/**
 目标类实现的协议名
 */
@property (copy, nonatomic) NSString *providerProtocolName;

/**
 目标类名
 */
@property (copy, nonatomic) NSString *targetClassName;

/**
 对应的实例对象
 */
@property (strong, nonatomic) id __nullable target;

@end

NS_ASSUME_NONNULL_END
