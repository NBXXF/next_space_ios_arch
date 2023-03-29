//
//  NSObject+KVOSafe.m
//  AFNetworking
//。JJException框架在kvo 上有不少bug,这里先自己安全处理
//  Created by XXF on 2023/3/29.
//

#import "NSObject+NXKVOSafe.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>
@implementation NSObject(NXKVOSafe)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(removeObserver:forKeyPath:)
                                   swizzledSelector:@selector(_hook_safe_removeObserver:forKeyPath:)];
        
        [NSObject nx_swizzleInstanceMethodWithClass:[self class]
                                   originalSelector:@selector(removeObserver:forKeyPath:context:)
                                   swizzledSelector:@selector(_hook_safe_removeObserver:forKeyPath:context:)];
    });
}
- (void)_hook_safe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context{
    @try {
        if(observer){
            [self _hook_safe_removeObserver:observer forKeyPath:keyPath context:context];
        }
    } @catch (NSObject *exception) {
#if DEBUG
        NSAssert(NO, @"dispose释放异常");
#else

#endif
    }
}

- (void)_hook_safe_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    @try {
        if(observer){
            [self _hook_safe_removeObserver:observer forKeyPath:keyPath];
        }
    } @catch (NSObject *exception) {
#if DEBUG
        NSAssert(NO, @"dispose释放异常");
#else

#endif
    }
}
@end
