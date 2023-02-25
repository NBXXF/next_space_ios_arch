//
//  NSURL+NXHttpHook.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/9.
//

#import "NSURL+NXHttpHook.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>

@implementation NSURL(NXHttpHook)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject exchangeInstanceMethodWithSelfClass:self.class
                                     originalSelector:@selector(initWithString:relativeToURL:)           swizzledSelector:@selector(_hook_initWithString:relativeToURL:)];
    });
}

- (nullable instancetype)_hook_initWithString:(NSString *)URLString relativeToURL:(nullable NSURL *)baseURL{
    
    /**
     这种情况会有问题 会导致/api 路径不见了
     NSURL *appendUrl=[NSURL URLWithString:@"/user/xxxx"];
     NSURL *baseURL=[NSURL URLWithString:@"https://www.baidu.com/api/"];
     NSString *FULL= [NSURL URLWithString:appendUrl.absoluteString relativeToURL:baseURL].absoluteString;
     */
    NSString *prefix=@"/";
    if([URLString hasPrefix:prefix]&&![URLString isEqual:prefix]){
        return [self initWithString:[URLString substringFromIndex:prefix.length] relativeToURL:baseURL];
    }else{
        return [self initWithString:URLString relativeToURL:baseURL];
    }
}
@end
