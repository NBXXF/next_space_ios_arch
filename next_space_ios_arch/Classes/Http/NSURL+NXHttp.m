//
//  NSURL+NXHttp.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/9.
//

#import "NSURL+NXHttp.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>

@implementation NSURL(NXHttp)

/**
 HOOK 会导致路由框架有问题 JLRoute
  NSURL *baseURL = [NSURL URLWithString:@"http://example.com/v1/"];
  [NSURL URLWithString:@"foo" relativeToURL:baseURL];                  // http://example.com/v1/foo
  [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];          // http://example.com/v1/foo?bar=baz
  [NSURL URLWithString:@"/foo" relativeToURL:baseURL];                 // http://example.com/foo    解决这个问题
  [NSURL URLWithString:@"foo/" relativeToURL:baseURL];                 // http://example.com/v1/foo
  [NSURL URLWithString:@"/foo/" relativeToURL:baseURL];                // http://example.com/foo/  解决这个问题
  [NSURL URLWithString:@"http://example2.com/" relativeToURL:baseURL]; // http://example2.com/
 */
+ (instancetype)URLWithURLPath:(NSString *)path relativeToURL:(NSURL *)baseURL{
    return [self URLWithString:[self formatURLPathWithPath:path] relativeToURL:baseURL];
}


+ (NSString *)formatURLPathWithPath:(NSString *)path{
    NSString *prefix=@"/";
    if([path hasPrefix:prefix]&&![path isEqual:prefix]){
        return [path substringFromIndex:prefix.length];
    }
    return path;
}

@end
