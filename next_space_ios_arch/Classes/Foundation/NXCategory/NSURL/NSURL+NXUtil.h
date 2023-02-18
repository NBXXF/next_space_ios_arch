//
//  NSURL+NXUtil.h
//  NX
//
//  Created by hedeyong on 2021/06/20.
//  Copyright © 2021年 NextSpace All rights reserved.
//

#import <Foundation/Foundation.h>

#define UrlGetArgumentsOccurError @"__getObjFailed__"

@interface NSURL (NXUtil)

/*!
 @method isEmpty:
 @abstract 是否合法的URL；不合法YES;
 @param object 验证对象
 @result 返回BOOL
 */
+ (BOOL)nx_isEmpty:(NSURL * _Nonnull)object;

/*!
 @method URLWithStringCheck:
 @abstract 指定url字符串返加 NSURL,会检查 URLString
 @param URLString url字符串
 @result 返回 NSURL
 */
+ (nullable instancetype)nx_URLWithStringCheck:(NSString * _Nonnull)URLString;

/*!
 @method URLWithStringCheck:relativeToURL:
 @abstract 指定url字符串返加 NSUR,会检查 URLString
 @param URLString url字符串
 @param baseURL base URL
 @result 返回 NSURL
 */
+ (nullable instancetype)nx_URLWithStringCheck:(NSString * _Nonnull)URLString relativeToURL:(nullable NSURL *)baseURL;

/*!
 @method arguments:
 @abstract 获取URL参数
 @result 返回 NSDictionary
 */
- (NSDictionary * _Nullable)nx_arguments;

@end
