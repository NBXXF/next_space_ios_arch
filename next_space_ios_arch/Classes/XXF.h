//
//  XXF.h
//  AFNetworking
//
//  Created by XXF on 2022/8/24.
//

#import <Foundation/Foundation.h>
typedef CGFloat(^NXPTConvertBlock)(CGFloat value);
NS_ASSUME_NONNULL_BEGIN

@interface XXF : NSObject
/**
 设置相对转换的回调
 */
+(void)setPTWithBlock:(NXPTConvertBlock)block;

/**
 转换相对单位
 */
+(CGFloat)convertPTFromPX:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
