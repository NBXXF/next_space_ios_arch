//
//  UIView+AppArchRect.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(AppArchRect)
/**
 转换成window的像素点
 */
-(CGPoint)convertPointToWindow;


/**
 转换成window的像素点
 */
-(CGRect)convertRectToWindow;


/**
 是否水平居中
 */
-(BOOL)isHorizontalCenterForTarget:(UIView *)target;

/**
 是否水平居中
 */
-(BOOL)isHorizontalCenterForTarget:(UIView *)target distance:(CGFloat)distance;

/**
 是否垂直居中
 */
-(BOOL)isVerticalCenterForTarget:(UIView *)target;

/**
 是否垂直居中
 */
-(BOOL)isVerticalCenterForTarget:(UIView *)target distance:(CGFloat)distance;


/**
 是否是target的左边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
-(BOOL)isLeftForTarget:(UIView *)target strict:(BOOL)strict;


/**
 是否是target的右边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
-(BOOL)isRightForTarget:(UIView *)target strict:(BOOL)strict;



/**
 是否是target的上边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
-(BOOL)isUpForTarget:(UIView *)target strict:(BOOL)strict;



/**
 是否是target的下边
 @param target 相对参考位置
 @param strict 是否抛弃重叠情况
 */
-(BOOL)isDownForTarget:(UIView *)target strict:(BOOL)strict;


@end

NS_ASSUME_NONNULL_END
