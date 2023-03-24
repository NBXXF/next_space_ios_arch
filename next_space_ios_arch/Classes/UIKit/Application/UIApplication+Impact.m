//
//  UIApplication+Impact.m
//  next_space_ios_arch
//  执行震动反馈
//  Created by XXF on 2023/3/24.
//

#import "UIApplication+Impact.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>

@implementation UIApplication(Impact)
+ (void)load{
    [self nx_swizzleInstanceMethodWithClass:[self class] originalSelector:@selector(sendEvent:) swizzledSelector:@selector(_hook_impact_sendEvent:)];
    [self nx_swizzleInstanceMethodWithClass:[self class] originalSelector:@selector(sendAction:to:from:forEvent:) swizzledSelector:@selector(_hook_impact_sendAction:to:from:forEvent:)];
}

- (void)_hook_impact_sendEvent:(UIEvent *)event{
    if(event.type== UIEventTypeTouches){
        UITouch *touch= event.allTouches.allObjects.firstObject;
        if(touch.phase==UITouchPhaseBegan&&[touch.view conformsToProtocol:@protocol(Feedbackable)]){
            id<Feedbackable> object=touch.view;
            if(object.fb_impactEnable){
                [object fb_prepareImpact];
            }
        }
    }
}
- (BOOL)_hook_impact_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event{
    BOOL send=[self _hook_impact_sendAction:action to:target from:sender forEvent:event];
    if(send){
        if([sender conformsToProtocol:@protocol(Feedbackable)]){
            id<Feedbackable> object=sender;
            if(object.fb_impactEnable){
                [object fb_performImpact];
            }
        }
    }
    return send;
}
@end
