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

- (nullable instancetype)_hook_initWithString:(NSString *)urlString relativeToURL:(nullable NSURL *)baseURL{
    
    /**
     这种情况会有问题 会导致/api 路径不见了  拼接的路径是以斜杠开始的情况
     NSURL *appendUrl=[NSURL URLWithString:@"/user/xxxx"];
     NSURL *baseURL=[NSURL URLWithString:@"https://www.baidu.com/api/"];
     NSString *FULL= [NSURL URLWithString:appendUrl.absoluteString relativeToURL:baseURL].absoluteString;
     */
    NSString *prefix=@"/";
    if([urlString hasPrefix:prefix]&&![urlString isEqual:prefix]){
        return [self _hook_initWithString:[urlString substringFromIndex:prefix.length] relativeToURL:baseURL];
    }else{
        return [self _hook_initWithString:urlString relativeToURL:baseURL];
    }
}
@end
