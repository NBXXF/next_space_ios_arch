//
//  NSString+Tool.h
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Tool)

/**
 *  移除所有空格
 *
 *  @return 移除空格后的字符串
 */
- (NSString*)removeAllSpace;

/**
 *  移除字符串两端的空格
 *
 *  @return 字符串
 */
-(NSString *)trim;


/**
 *  字符串转换为URL（已经经过UTF－8 处理）
 *
 *  @return NSURL
 */
- (NSURL *)toURL;

/**
 *  判断是否是Email
 *
 *  @return YES，NO
 */
- (BOOL)isEmail;

/**
 *  判断是否为空（nil,"",空格都可以判断）
 *
 *  @return YES，NO
 */
- (BOOL)isEmpty;


- (NSString *) escapeHTML;
- (NSString *) unescapeHTML;

/**
 *  移除HTML标签
 *
 *  @return 字符串
 */
- (NSString *) stringByRemovingHTML;

/**
 *  MD5 加密
 *
 *  @return MD5加密后的字符串
 */
- (NSString *)MD5;

/**
 *  得到拼音
 *
 *  @return 字符串的拼音
 */
- (NSString *)pinYin;

///编码
- (NSString * )URLEncode;
///解码
-(NSString *)URLDecoded;


/**
 *  比较，是不是老版本
 *
 *  @param otherVersion 要比较的版本
 *
 *  @return YES，NO
 */
-(BOOL) isOlderVersionThan:(NSString*)otherVersion;

/**
 *  比较是不是新版本
 *
 *  @param otherVersion 要比较的版本
 *
 *  @return YES，NO
 */
-(BOOL) isNewerVersionThan:(NSString*)otherVersion;

#pragma mark - coding.net emoji

-(BOOL)containsEmoji;


+ (NSString *)randomStringWithLength:(NSInteger)len;



/** 解zip压缩 */
+ (NSData *)gzipInflate:(NSData*)data;
///隐藏部分昵称
//- (NSString *)encryptNickName;



@end
