//
//  UIApplication+Impact.m
//  next_space_ios_arch
//  执行震动反馈
//  Created by XXF on 2023/3/24.
//

#import "UIApplication+Feedback.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>
#import <next_space_ios_arch/UIView+Feedback.h>
#import <next_space_ios_arch/UIResponder+NXTools.h>
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation UIApplication(Feedback)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self nx_swizzleInstanceMethodWithClass:[self class]
                               originalSelector:@selector(sendEvent:)
                               swizzledSelector:@selector(_hook_impact_sendEvent:)];
        [self nx_swizzleInstanceMethodWithClass:[self class]
                               originalSelector:@selector(sendAction:to:from:forEvent:)
                               swizzledSelector:@selector(_hook_impact_sendAction:to:from:forEvent:)];
    });
  
}

/**
 所有事件都会来
 */
- (void)_hook_impact_sendEvent:(UIEvent *)event{
    if(event.type== UIEventTypeTouches){
        UITouch *touch= event.allTouches.allObjects.firstObject;
        if(touch.phase==UITouchPhaseBegan){
            if(touch.view.allowFeedback){
                [touch.view prepareFeedback];
            }
            
            [self _log_touch_start_view_statck:touch.view];
        }
    }
    return [self _hook_impact_sendEvent:event];
}

/**
 只有UIControl及其子类会响应
 */
- (BOOL)_hook_impact_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event{
    BOOL send=[self _hook_impact_sendAction:action to:target from:sender forEvent:event];
    if(send){
        if([sender isKindOfClass:UIView.class]){
            if(((UIView *)sender).allowFeedback){
                [((UIView *)sender) performFeedback];
            }
        }
    }
    return send;
}

-(void)_log_touch_start_view_statck:(UIView *)view{
#if DEBUG
    if(!view){
        return;
    }
    /**
     增加开发日志,方便粗略找寻组件以及层级,不用通过xcode 布局分析(慢)
     */
    __block NSString *touchStack=@"";
    [view findNextResponderBlock:^BOOL(UIResponder * _Nonnull nextResponder) {
        touchStack=[touchStack stringByAppendingFormat:@"   -->%@",nextResponder.simpleDescription];
        return [nextResponder isKindOfClass:UIViewController.class];
    }];
    NSLog(@"========>touch responder%@",touchStack);
#else
     
#endif
}
@end
