//
//  UITableViewCell+Animation.m
//  next_space_ios_arch
//  增加动画
//  Created by 1234 on 2023/3/25.
//

#import "UITableViewCell+Animation.h"
#import <next_space_ios_arch/UIView+Animation.h>
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/NSObject+NXAssociation.h>

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



-(NSString *)_keyAllowAnimationForHighlight{
    return NSStringFromSelector(@selector(allowAnimationForHighlight));
}
- (BOOL)allowAnimationForHighlight{
    //默认NO
    id result=[self nx_getAssociatedObject:self._keyAllowAnimationForHighlight]?:@(NO);
    return [result boolValue];
}

- (void)setAllowAnimationForHighlight:(BOOL)allowAnimationForHighlight{
    [self nx_setAssociatedObject:@(allowAnimationForHighlight)
                          forKey:self._keyAllowAnimationForHighlight
                          policy:NX_ASSOCIATION_ASSIGN];
}
@end
