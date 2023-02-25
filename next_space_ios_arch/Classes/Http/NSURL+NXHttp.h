//
//  NSURL+NXHttp.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL(NXHttp)

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
+ (nullable instancetype)URLWithURLPath:(NSString *)path relativeToURL:(nullable NSURL *)baseURL;

/**
 去除path 首位是斜杠的情况
 */
+ (NSString *)formatURLPathWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
