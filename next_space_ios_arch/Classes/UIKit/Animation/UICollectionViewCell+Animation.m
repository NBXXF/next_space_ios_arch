//
//  UICollectionViewCell+animation.m
//  next_space_ios_arch
//  为UICollectionViewCel增加动画
//  Created by XXF on 2023/3/25.
//

#import "UICollectionViewCell+Animation.h"
#import <next_space_ios_arch/UIView+Animation.h>
#import <next_space_ios_arch/NSObject+Swizzling.h>


@implementation UICollectionViewCell(Animation)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(setHighlighted:)
                                   swizzledSelector:@selector(_hook_animation_setHighlighted:)];
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(prepareForReuse)
                                   swizzledSelector:@selector(_hook_animation_prepareForReuse)];
    });
}

- (void)_hook_animation_prepareForReuse{
    NSString *key= NSStringFromSelector(@selector(animationDuration));
    [self pop_removeAnimationForKey:key];
    [self _hook_animation_prepareForReuse];
}

-(void)_hook_animation_setHighlighted:(BOOL)highlighted{
    if(highlighted&&self.allowAnimationForHighlight){
        [self animateWithBounce];
    }
    [self _hook_animation_setHighlighted:highlighted];
}

@end
