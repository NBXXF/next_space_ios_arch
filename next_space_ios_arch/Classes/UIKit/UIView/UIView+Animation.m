//
//  UIView+Animation.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/25.
//

#import "UIView+Animation.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>

@implementation UIView(Animation)

+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
//                                   originalSelector:@selector(setHighlighted:)
//                                   swizzledSelector:@selector(_hook_animation_setHighlighted:animated:)];
//    });
}


- (void)animateWithBounce{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    scaleAnimation.springBounciness = 20.f;
    [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}
@end
