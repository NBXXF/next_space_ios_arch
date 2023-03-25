//
//  UICollectionViewCell+animation.m
//  next_space_ios_arch
//  为UICollectionViewCel增加动画
//  Created by XXF on 2023/3/25.
//

#import "UICollectionViewCell+Animation.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>


@implementation UICollectionViewCell(Animation)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(setHighlighted:)
                                   swizzledSelector:@selector(_hook_animation_setHighlighted:)];
    });
}

-(void)_hook_animation_setHighlighted:(BOOL)highlighted{
    [self _hook_animation_setHighlighted:highlighted];
    //增加默认动画
//    if (self.highlighted) {
//        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//        scaleAnimation.duration = 0.1;
//        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.95, 0.95)];
//        [self.contentView pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//    } else {
//        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
//        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
//        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
//        scaleAnimation.springBounciness = 20.f;
//        [self.contentView pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//    }
}
@end
