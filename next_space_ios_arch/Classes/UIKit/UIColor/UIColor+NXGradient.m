//
//  UIColor+NXGradient.m
//  AFNetworking
//
//  Created by 1234 on 2022/11/21.
//

#import "UIColor+NXGradient.h"

@implementation UIColor(NXGradient)
+ (instancetype)gradientColorWithSize:(CGSize)size
                            direction:(GradientColorDirection)direction
                           startColor:(UIColor *)startcolor
                             endColor:(UIColor *)endColor {
    
    if (CGSizeEqualToSize(size, CGSizeZero) || !startcolor || !endColor) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointMake(0.0, 0.0);
    if (direction == GradientColorDirectionUpwardDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    
    CGPoint endPoint = CGPointMake(0.0, 0.0);
    switch (direction) {
        case GradientColorDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case GradientColorDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case GradientColorDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            endPoint = CGPointMake(1.0, 0.0);
            break;
    }
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)startcolor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}
@end
