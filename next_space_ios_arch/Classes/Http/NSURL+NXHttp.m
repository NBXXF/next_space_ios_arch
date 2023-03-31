//
//  NSURL+NXHttp.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/9.
//

#import "NSURL+NXHttp.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>

@implementation NSURL(NXHttp)

+ (BOOL)isWEBURLWithString:(NSString *)str{
    if(str){
        NSString *webRegex = @"[a-zA-z]+://.*";
        NSPredicate *webTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", webRegex];
        return [webTest evaluateWithObject:str];
    }
    return NO;
}

/**
 HOOK 会导致路由框架有问题 JLRoute
  NSURL *baseURL = [NSURL URLWithString:@"http://example.com/v1/"];
  [NSURL URLWithString:@"foo" relativeToURL:baseURL];                  // http://example.com/v1/foo
  [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];          // http://example.com/v1/foo?bar=baz
  [NSURL URLWithString:@"/foo" relativeToURL:baseURL];                 // http://example.com/foo    解决这个问题
  [NSURL URLWithString:@"foo/" relativeToURL:baseURL];                 // http://example.com/v1/foo
  [NSURL URLWithString:@"/foo/" relativeToURL:baseURL];                // http://example.com/foo/  解决这个问题
  [NSURL URLWithString:@"http://example2.com/" relativeToURL:baseURL]; // http://example2.com/
 
 @param encoded 是否已经处理了编码,如果NO 将处理特殊符号编码
 */
+ (instancetype)URLWithURLPath:(NSString *)path relativeToURL:(NSURL *)baseURL encoded:(BOOL)encoded{
    return [self URLWithString:[self formatURLPathWithPath:path encoded:encoded] relativeToURL:baseURL];
}


/**
  处理拼接问题
 @param encoded 是否已经处理了编码,如果NO 将处理特殊符号编码
 */
+ (NSString *)formatURLPathWithPath:(NSString *)path  encoded:(BOOL)encoded{
    NSString *prefix=@"/";
    NSString *formated=path;
    if([path hasPrefix:prefix]&&![path isEqual:prefix]){
        formated=[path substringFromIndex:prefix.length];
    }else{
        formated=path;
    }
    
    if(!encoded){
        formated=[formated stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    return formated;
}


@end
