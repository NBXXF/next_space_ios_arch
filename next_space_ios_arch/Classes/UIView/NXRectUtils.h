//
//  NXCGRectUtils.h
//  next_space_ios_arch
//  CGRect工具类
//  Created by XXF on 2022/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXRectUtils : NSObject

/**
 获取前x 轴中心点
 */
+(CGFloat)getCenterX:(CGRect)rect;

/**
 获取y轴中心点
 */
+(CGFloat)getCenterY:(CGRect)rect;



/**
 是否水平方向居中
 */
+(BOOL)isHorizontalCenter:(CGRect)current target:(CGRect)target;

/**
 是否水平方向居中 忽略差距
 */
+(BOOL)isHorizontalCenter:(CGRect)current target:(CGRect)target distance:(CGFloat)distance;

/**
 是否垂直方向居中
 */
+(BOOL)isVerticalCenter:(CGRect)current target:(CGRect)target;

/**
 是否垂直方向居中  忽略差距
 */
+(BOOL)isVerticalCenter:(CGRect)current target:(CGRect)target distance:(CGFloat)distance;

/**
 是否是target的左边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isLeft:(CGRect)current target:(CGRect)target strict:(BOOL)strict;



/**
 是否是target的右边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isRight:(CGRect)current target:(CGRect)target strict:(BOOL)strict;



/**
 是否是target的上边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isUp:(CGRect)current target:(CGRect)target strict:(BOOL)strict;



/**
 是否是target的下边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
+(BOOL)isDown:(CGRect)current target:(CGRect)target strict:(BOOL)strict;


@end

NS_ASSUME_NONNULL_END
