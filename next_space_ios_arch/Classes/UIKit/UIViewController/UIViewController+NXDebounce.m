//
//  UIViewController+NXDebounce.m
//  next_space_ios_arch
//  弹窗限流,全局hook,避免有些组件没有继承关系
//  Created by XXF on 2023/3/22.
//

#import "UIViewController+NXDebounce.h"
#import <next_space_ios_arch/NSObject+RateLimiting.h>
#import <next_space_ios_arch/NSObject+Swizzling.h>
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <next_space_ios_arch/NSObject+NXRACSignalSupport.h>
#import <next_space_ios_arch/UIView+Feedback.h>

@implementation UIViewController(NXDebounce)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:self originalSelector:@selector(presentViewController:animated:completion:) swizzledSelector:@selector(_hook_presentViewController:animated:completion:)];
    });
}

- (void)_hook_presentViewController:(UIViewController *)viewControllerToPresent
                           animated: (BOOL)flag
                         completion:(void (^ __nullable)(void))completion NS_SWIFT_DISABLE_ASYNC API_AVAILABLE(ios(5.0)){
    //触觉震动反馈
    [FeedbackGenerator.shared performDefaultFeedback];
    
    //有动画的情况,拦截,没动画 不用管,系统阻塞快
    if(flag){
        //注意多方冲突 类+类+行 唯一性较高。屏蔽同一个类型 多种实例类型弹窗
        NSString *key=[NSString stringWithFormat:@"%@_%@",NSStringFromClass(viewControllerToPresent.class),__FILE_LINE__];
        if([NSObject isRateLimitingWithId:key duration:0.5]){
            NSLog(@"==========>rateLimiting for presentViewController");
            return;
        }
    }
    [self _hook_presentViewController:viewControllerToPresent animated:flag completion:completion];
}


@end
