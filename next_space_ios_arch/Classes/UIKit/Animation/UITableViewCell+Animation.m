//
//  UITableViewCell+Animation.m
//  next_space_ios_arch
//  增加动画
//  Created by XXF on 2023/3/25.
//

#import "UITableViewCell+Animation.h"
#import <next_space_ios_arch/UIView+Animation.h>
#import <next_space_ios_arch/NSObject+Swizzling.h>

@implementation UITableViewCell(Animation)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(setHighlighted:animated:)
                                   swizzledSelector:@selector(_hook_animation_setHighlighted:animated:)];
        
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

- (void)_hook_animation_setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if(highlighted&&!animated&&self.allowAnimationForHighlight){
        [self animateWithBounce];
    }
    [self _hook_animation_setHighlighted:highlighted animated:animated];
}

@end
