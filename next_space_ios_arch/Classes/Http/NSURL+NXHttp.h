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
 替换成IP
 */
+(instancetype)URLWithURL:(NSURL *)url replaceIP:(NSString *)ip;
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
+ (nullable instancetype)URLWithURLPath:(NSString *)path relativeToURL:(nullable NSURL *)baseURL encoded:(BOOL)encoded;

/**
 去除path 首位是斜杠的情况
 @param encoded 是否已经处理了编码,如果NO 将处理特殊符号编码
 */
+ (NSString *)formatURLPathWithPath:(NSString *)path encoded:(BOOL)encoded;

@end

NS_ASSUME_NONNULL_END
