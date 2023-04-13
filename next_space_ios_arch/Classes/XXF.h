//
//  XXF.h
//  AFNetworking
//
//  Created by XXF on 2022/8/24.
//

#import <Foundation/Foundation.h>
#import <next_space_ios_arch/XXFConfigOption.h>
//继承下去
#import <KVOMutableArray/KVOMutableArray-umbrella.h>

typedef NSString *_Nonnull(^NXUserIdProvider)(void);
typedef NSString *_Nonnull(^NXAppGroupNameProvider)(void);

NS_ASSUME_NONNULL_BEGIN

@interface XXF : NSObject

@property(nonatomic,strong,readonly,class) XXF *shared;
@property(nonatomic,strong)XXFConfigOption *config;



+(void)initWithConfig:(NXAppGroupNameProvider)appGroupNameProvider
       userIdProvider:(NXUserIdProvider)userIdProvider DEPRECATED_MSG_ATTRIBUTE("过时了");

+(void)initWithConfig:(NXAppGroupNameProvider)appGroupNameProvider
       userIdProvider:(NXUserIdProvider)userIdProvider
     configOption:(XXFConfigOption *)option;

/**
 转换相对单位
 */
+(CGFloat)convertPTFromPX:(CGFloat)value;

//获取userId
+(NSString *_Nonnull)getUserId DEPRECATED_MSG_ATTRIBUTE("仅限于框架使用,业务代码勿调");

//获取GroupName
+(NSString *_Nonnull)getAppGroupName;

/**
 开始性能监控
 */
+(void)startPerformanceMonitor:(CGFloat)threshold  DEPRECATED_MSG_ATTRIBUTE("已经移动到框架内部了 便于推进性能提升进程");


@end

NS_ASSUME_NONNULL_END
