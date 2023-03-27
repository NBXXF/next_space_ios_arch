//
//  UIControl+Animation.m
//  next_space_ios_arch
//  为UIControl 增加默认的动画
//  Created by XXF on 2023/3/27.
//

#import "UIControl+Animation.h"
#import <next_space_ios_arch/UIView+Animation.h>
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/NSObject+NXAssociation.h>

@implementation UIControl(Animation)


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(setHighlighted:)
                                   swizzledSelector:@selector(_hook_animation_setHighlighted:)];
    });
}

-(NSString *)_keyAllowAnimationForHighlight{
    return NSStringFromSelector(@selector(allowAnimationForHighlight));
}
- (BOOL)allowAnimationForHighlight{
    //默认YES
    id result=[self nx_getAssociatedObject:self._keyAllowAnimationForHighlight]?:@(YES);
    return [result boolValue];
}

- (void)setAllowAnimationForHighlight:(BOOL)allowAnimationForHighlight{
    [self nx_setAssociatedObject:@(allowAnimationForHighlight)
                          forKey:self._keyAllowAnimationForHighlight
                          policy:NX_ASSOCIATION_ASSIGN];
}

- (void)_hook_animation_setHighlighted:(BOOL)highlighted{
    if(highlighted&&self.allowAnimationForHighlight){
        [self animateWithBounce];
    }
    [self _hook_animation_setHighlighted:highlighted];
}
@end
