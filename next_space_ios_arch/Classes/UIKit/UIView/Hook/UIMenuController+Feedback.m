//
//  UIMenuController+Feedback.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/25.
//

#import "UIMenuController+Feedback.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/UIView+Feedback.h>

@implementation UIMenuController(Feedback)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(showMenuFromView:rect:)
                                   swizzledSelector:@selector(_hook_showMenuFromView:rect:)];
        
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(setMenuVisible:animated:)
                                   swizzledSelector:@selector(_hook_setMenuVisible:animated:)];
    });
}
- (void)_hook_showMenuFromView:(UIView *)targetView rect:(CGRect)targetRect{
    //为ACTION菜单显示增加反馈 震动反馈
    [FeedbackGenerator.shared performDefaultFeedback];
    [self _hook_showMenuFromView:targetView rect:targetRect];
}

- (void)_hook_setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated{
    if(menuVisible){
        //为ACTION菜单显示增加反馈 震动反馈
        [FeedbackGenerator.shared performDefaultFeedback];
        [self _hook_setMenuVisible:menuVisible animated:animated];
    }
}
@end
