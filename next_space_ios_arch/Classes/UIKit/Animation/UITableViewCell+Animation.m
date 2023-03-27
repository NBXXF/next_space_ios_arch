//
//  UITableViewCell+Animation.m
//  next_space_ios_arch
//  增加动画
//  Created by 1234 on 2023/3/25.
//

#import "UITableViewCell+Animation.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/UIView+Animation.h>

@implementation UITableViewCell(Animation)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(setHighlighted:)
                                   swizzledSelector:@selector(_hook_animation_setHighlighted:animated:)];
    });
}

- (void)_hook_animation_setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if(highlighted){
        [self animateWithBounce];
    }
    [self _hook_animation_setHighlighted:highlighted animated:animated];
  
//    if (self.highlighted) {
//        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//        scaleAnimation.duration = 0.1;
//        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
//        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//        
//    } else {
//        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
//        scaleAnimation.springBounciness = 20.f;
//        [self.textLabel pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//    }
}
@end
