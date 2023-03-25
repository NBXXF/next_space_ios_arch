//
//  UIView+swizzleFrame.m
//  next_space
//
//

#import "UIView+swizzleFrame.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/UIView+Feedback.h>

@implementation UIView (SwizzleFrame)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(setFrame:)
                                   swizzledSelector:@selector(swizzle_setFrame:)];
        
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(initWithFrame:)
                                   swizzledSelector:@selector(_hook_initWithFrame:)];
    });

}

// 应为M1 ipad 不支持设置 autocorrectionType saveWindowFrame 会设置一个Null 导致崩溃  但是 autocorrectionType 是协议属性不好拦截 这里直接拦截setFrame
- (void)swizzle_setFrame:(CGRect)frame{
    if(CGRectIsNull(frame)){
        [self swizzle_setFrame:CGRectZero];
    }else{
        [self swizzle_setFrame:frame];
    }
}


/**
 触觉反馈 震动反馈 默认组件
 */
- (instancetype)_hook_initWithFrame:(CGRect)frame{
    UIView *result = [self _hook_initWithFrame:frame];
    if(result){
        /**
         默认反馈的组件
         默认增加震动的组件
         默认清单
         */
        if([result isKindOfClass:UISwitch.class]
           ||[result isKindOfClass:UISegmentedControl.class]
           ||[result isKindOfClass:UIButton.class]
           ||[result isKindOfClass:UIStepper.class]
           ||[result isKindOfClass:UISlider.class]
           ){
            result.allowFeedback=YES;
        }
    }
    return result;
}

@end
