//
//  RACDisposable+AppArch.m
//  AppArch
//  解决安全问题
//  Created by XXF on 2022/9/20.
//

#import "RACDisposable+AppArch.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>


@implementation RACDisposable(AppArch)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(dispose)
                                   swizzledSelector:@selector(_hook_safe_dispose)];
    });
}

-(void)_hook_safe_dispose{
    @try {
        BOOL isMainThread=[[NSThread currentThread] isMainThread];
        if(!isMainThread){
             //避免多线程出现野指针
            @synchronized (RACDisposable.class) {
                if(!self.isDisposed){
                    [self _hook_safe_dispose];
                }
            }
        }else{
            if(!self.isDisposed){
                [self _hook_safe_dispose];
            }
        }
    } @catch (NSObject *exception) {
#if DEBUG
        NSAssert(NO, @"dispose释放异常");
#else

#endif
    }
}
/**
 目前是否存在野指针闪退的问题
 调用多次 和kvo 容易出现
 */
- (void)disposeSafe{
    @try {
        BOOL isMainThread=[[NSThread currentThread] isMainThread];
        if(!isMainThread){
             //避免多线程出现野指针
            @synchronized (RACDisposable.class) {
                if(!self.isDisposed){
                    [self dispose];
                }
            }
        }else{
            if(!self.isDisposed){
                [self dispose];
            }
        }
    } @catch (NSObject *error) {
#if DEBUG
        NSAssert(NO, @"dispose释放异常");
#else

#endif
    }
}
@end
