//
//  UIView+Animation.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/25.
//

#import "UIView+Animation.h"

@implementation UIView(Animation)


- (void)animateWithBounce{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    scaleAnimation.springBounciness = 20.f;
    
    NSString *key= NSStringFromSelector(@selector(animationDuration));
    
    [self pop_addAnimation:scaleAnimation forKey:key];
}
@end
