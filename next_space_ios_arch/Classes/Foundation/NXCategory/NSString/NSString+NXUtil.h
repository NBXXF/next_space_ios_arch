//
//  NSString+NXUtil.h
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define HK_isEmptyString(object)        [NSString     isEmpty:object]

@interface NSString (NXUtil)

/*!
 @method charValue
 @abstract 把字符串转为char类型
 @result 返回char
 */
- (char)nx_charValue;

/*!
 @method unsignedCharValue
 @abstract 把字符串转为unsigned char类型
 @result 返回unsigned char
 */
- (unsigned char)nx_unsignedCharValue;

/*!
 @method boolValue
 @abstract 把字符串转为BOOL类型
 @result 返回BOOL
 */
- (BOOL)nx_boolValue;

/*!
 @method shortValue
 @abstract 把字符串转为short类型
 @result 返回short
 */
- (short)nx_shortValue;

/*!
 @method unsignedShortValue
 @abstract 把字符串转为unsigned short类型
 @result 返回unsigned short
 */
- (unsigned short)nx_unsignedShortValue;

/*!
 @method unsignedIntValue
 @abstract 把字符串转为unsigned int类型
 @result 返回unsigned int
 */
- (unsigned int)nx_unsignedIntValue;

/*!
 @method longValue
 @abstract 把字符串转为long类型
 @result 返回long
 */
- (long)nx_longValue;

/*!
 @method unsignedLongValue
 @abstract 把字符串转为unsigned long类型
 @result 返回unsigned long
 */
- (unsigned long)nx_unsignedLongValue;

/*!
 @method unsignedLongLongValue
 @abstract 把字符串转为unsigned long long类型
 @result 返回unsigned long long
 */
- (unsigned long long)nx_unsignedLongLongValue;

/*!
 @method unsignedIntegerValue
 @abstract 把字符串转为NSUInteger类型
 @result 返回NSUInteger
 */
- (NSUInteger)nx_unsignedIntegerValue;

/*!
 @method numberValue
 @abstract 把字符串转为NSNumber类型
 @result 返回NSNumber
 */
- (NSNumber *)nx_numberValue;


/// 字符串中只包含数字字符
- (BOOL)nx_onlyContainsNumbers;
/*!
 @method arrayValue
 @abstract 把字符串转为NSArray类型
 @result 返回NSArray
 */
- (NSArray *)nx_arrayValue;

/*!
 @method dictionaryValue
 @abstract 把字符串转为NSDictionary类型
 @result 返回NSDictionary
 */
- (NSDictionary *)nx_dictionaryValue;

/*!
 @method dataValue
 @abstract 把字符串转为NSData类型，只支持UTF-8有损转换；排UTF-8编码的请用 dataUsingEncoding: 方法转
 @result 返回NSData
 */
- (NSData *)nx_dataValue;

/*!
 @method decimalValue
 @abstract 把字符串转为NSDecimal类型
 @result 返回NSDecimal
 */
- (NSDecimal)nx_decimalValue;

/*!
 @method decimalNumberValue
 @abstract 把字符串转为NSDecimalNumber类型
 @result 返回NSDecimalNumber
 */
- (NSDecimalNumber *)nx_decimalNumberValue;

- (NSString *)nx_firstNumberStr;
/*!
 @method urlValue
 @abstract 把字符串转为NSUrl类型
 @result 返回urlValue
 */
- (NSURL *)nx_urlValue;

/*!
 @method urlUTF8Value
 @abstract 把字符串转为NSUrl类型 如果不成功在进行一次utf-8的转换
 @result 返回urlValue
 */
- (NSURL *)nx_urlUTF8Value;

/*!
 @method trim
 @abstract 去除两端的空字符
 @result 返回去除两端的空字符的字符串
 */
- (NSString *)nx_trim;

/*!
 @method md5
 @abstract 把字符串加密成md5
 @result 返回md5加密字符串
 */
- (NSString *)nx_md5;

/*!
 @method sha256
 @abstract 把字符串加密成sha256
 @result 返回sha256加密字符串
 */
- (NSString *)nx_SHA256;
//MARK: 网络相关
/*!
 @method stringByUrlEncoding
 @abstract 转义合法的URL字符串，默认编码为kCFStringEncodingUTF8，与stringByUrlDecode方法相反
 @result 返回URL字符串
 */
- (NSString *)nx_stringByUrlEncoding;


/// 添加请求参数如: command=xxx
- (NSString *)nx_appendQueryString:(NSString *)queryString;
/*!
 @method stringByUrlEncoding:
 @abstract 转义合法的URL字符串，与stringByUrlDecode方法相反
 @param encoding 编码
 @result 返回URL字符串
 */
- (NSString *)nx_stringByUrlEncoding:(CFStringEncoding)encoding;

/*!
 @method stringByUrlDecode
 @abstract 把URL转义成正常字符串，默认编码为NSUTF8StringEncoding，与stringByUrlEncoding方法相反
 @result 返回字符串
 */
- (NSString *)nx_stringByUrlDecode;

/*!
 @method stringByUrlDecode:
 @abstract 把URL转义成正常字符串，与stringByUrlEncoding方法相反
 @param encoding 编码
 @result 返回字符串
 */
- (NSString *)nx_stringByUrlDecode:(NSStringEncoding)encoding;

/*!
 @method stringByUrlParameterDictionary:
 @abstract 把URL的参数转成NSDictionary，字符串a=1&b=2
 @result 返回NSDictionary
 */
- (NSDictionary *)nx_stringByUrlParameterDictionary;

/*!
 @method formatTimestamp:
 @abstract 把URL的参数转成YYYY-MM-dd HH:mm形式的时间
 @result 返回 NSString
 */
- (NSString *)nx_formatTimestamp;


/*!
 @method formatCommentTimestamp:
 @abstract 把参数转成 刚刚 x分钟前
 @result 返回 NSString
 */
- (NSString *)nx_formatCommentTimestamp;

/*!
 @method substringWithRangeCheck:
 @abstract 检测是否在合法范围内，在就返回字符
 @param range 截取范围
 @result 返回NSString
 */
- (NSString *)nx_substringWithRangeCheck:(NSRange)range;

/*!
 @method stringByRever
 @abstract 获取反向字符串
 @result 返回 NSString
 */
- (NSString *)nx_stringByRever;
 
+ (NSInteger)nx_apivNumberFromAPIVString:(NSString *)apiv;

+ (NSString *)nx_fileMD5HashCreateWithPath:(NSString *)filePath;

- (NSString *)nx_appIdString;

/*!
 @method convertToDictionary
 @abstract 将json字符串转换成Dictionary
 @result 返回Dictionary
 */
- (NSDictionary*)nx_convertToDictionary;

/*!
 @method substringFromIndexSafely
 @abstract 检测是否在合法范围内，在就返回字符
 @param atIndex 位置
 @result 返回NSString
 */
- (NSString *)nx_substringFromIndexSafely:(NSInteger)atIndex;
//{
//    if (self.length > atIndex) {
//        return [self substringFromIndex:atIndex];
//    }
//    return nil;
//}

/**
 判断自字符串中是否有非编码的特殊字符

 @return 如果有，将特殊字符进行编码
 */
- (NSString *)nx_checkLegalCharacterUrlString;


/**
 是否含有中文
 */
+ (BOOL)nx_checkHasChinese:(NSString *)string;

/**
 过滤Emoji字符
 */
+ (NSString *)nx_disableEmoji:(NSString *)text;

/**
 获取文字高度
 */
- (CGFloat)nx_heightWithFont:(UIFont *)font Width:(float)width;
/**
 获取文字宽度
 */
- (CGFloat)nx_widthWithFont:(UIFont *)font;
/**
 获取文字行数
 */
- (NSInteger)nx_stringLinesWithFont:(UIFont *)font width:(CGFloat)width;

/**
 文本长度

 @return 汉子 1 个字，数字和字符
 */
- (int)nx_textLength;

/**
 wifi mac
 */
+ (NSString *)nx_WiFiMacAddress;

/**
 wifi name
 */
+ (NSString *)nx_WifiName;
/**
 获取设备物理地址
*/
+ (NSString *)nx_iOSMacAddress;

- (BOOL)nx_checkHasEmoji;

- (NSAttributedString *)nx_attributeStringShadowWithShadowBlur:(CGFloat)blur shadowColor:(UIColor *)color;

- (NSAttributedString *)nx_attributeStringShadowWithShadowBlur:(CGFloat)blur shadowOffset:(CGSize)offset shadowColor:(UIColor *)color shadowRange:(NSRange)range;

- (NSComparisonResult)nx_compareVersion:(NSString *)string; // 版本号比较
//普通字符串转换为十六进制的。
- (NSString *)nx_hexStringFromString;
// 十六进制转换为普通字符串的。
- (NSString *)nx_stringFromHexString;

- (NSString*)nx_stringByUnescapingFromURLArgument;

-(NSString *)firstCharOrEmojiIfNeed;

+(NSString *)nx_uuidString;

- (NSString * __nullable)SHA256Base64;

- (NSArray *)rangeOfSubString:(NSString *)subStr;
@end
