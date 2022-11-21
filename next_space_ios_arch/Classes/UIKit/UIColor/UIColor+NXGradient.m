//
//  UIColor+NXGradient.m
//  AFNetworking
//
//  Created by 1234 on 2022/11/21.
//

#import "UIColor+NXGradient.h"
#import "UIImage+NXGradient.h"

@implementation UIColor(NXGradient)
+ (instancetype)gradientColorWithSize:(CGSize)size
                            direction:(GradientColorDirection)direction
                           startColor:(UIColor *)startcolor
                             endColor:(UIColor *)endColor {
    
    UIImage *image=[UIImage gradientImageWithSize:size direction:direction startColor:startcolor endColor:endColor];
    if(image){
        return [UIColor colorWithPatternImage:image];
    }
    return nil;
}


@end
