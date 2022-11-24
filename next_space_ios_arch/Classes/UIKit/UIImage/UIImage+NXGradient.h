//
//  UIImage+NXGradient.h
//  AFNetworking
//
//  Created by XXF on 2022/11/21.
//

#import <Foundation/Foundation.h>
#import "UIColor+NXGradient.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(NXGradient)
/// 设置渐变色
/// @param size 需要渐变的大小
/// @param direction 渐变的方向
/// @param startcolor 渐变的开始颜色
/// @param endColor 渐变的结束颜色
+ (instancetype)gradientImageWithSize:(CGSize)size
                            direction:(GradientColorDirection)direction
                           startColor:(UIColor *)startcolor
                             endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
