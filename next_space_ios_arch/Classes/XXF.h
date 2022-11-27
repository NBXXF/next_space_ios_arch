//
//  XXF.h
//  AFNetworking
//
//  Created by XXF on 2022/8/24.
//

#import <Foundation/Foundation.h>
typedef CGFloat(^NXPTConvertBlock)(CGFloat value);
typedef NSString *_Nonnull(^NXUserIdProvider)(void);
typedef NSString *_Nonnull(^NXAppGroupNameProvider)(void);


NS_ASSUME_NONNULL_BEGIN

@interface XXF : NSObject

+(void)initWithConfig:(NXPTConvertBlock)ptConvertBlock
 appGroupNameProvider:(NXAppGroupNameProvider)appGroupNameProvider
       userIdProvider:(NXUserIdProvider)userIdProvider;

/**
 转换相对单位
 */
+(CGFloat)convertPTFromPX:(CGFloat)value;

//获取userId
+(NSString *_Nonnull)getUserId;

//获取GroupName
+(NSString *_Nonnull)getAppGroupName;

@end

NS_ASSUME_NONNULL_END
