//
//  NSString+NXUtil.m
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import "NSString+NXUtil.h"
#import "NSArray+NXUtil.h"
#import "NSDictionary+NXUtil.h"
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CommonCrypto/CommonHMAC.h>
#define NX_CONVERT_USING(strtowhat) {\
char buf[24];\
if ([self getCString:buf maxLength:24 encoding:NSASCIIStringEncoding]) \
return strtowhat(buf, NULL, 10);\
} \
return strtowhat([self UTF8String], NULL, 10);

@implementation NSString (NXUtil)

+ (BOOL)nx_isEmpty:(NSString *)object;
{
    BOOL result = YES;
    if (object != nil && [object isKindOfClass:[NSString class]] && object.length > 0) {
        result = NO;
    }
    return result;
}

- (char)nx_charValue
{
    const char *str = [self UTF8String];
    return str[0];
}

- (unsigned char)nx_unsignedCharValue
{
    const char *str = [self UTF8String];
    return (unsigned char)str[0];
}

- (BOOL)nx_boolValue
{
    if (([self caseInsensitiveCompare:@"YES"] == NSOrderedSame)
        || ([self caseInsensitiveCompare:@"Y"]  == NSOrderedSame)
        || [self isEqualToString:@"1"]
        || ([self caseInsensitiveCompare:@"true"] == NSOrderedSame)
        || ([self caseInsensitiveCompare:@"t"] == NSOrderedSame)){
        return YES;
    }
    else {
        return NO;
    }
}

- (short)nx_shortValue
{
    int i = [self intValue];
    return (short)i;
}

- (unsigned short)nx_unsignedShortValue
{
    return (unsigned short)[self nx_unsignedLongValue];
}

- (unsigned int)nx_unsignedIntValue
{
    return (unsigned int)[self nx_unsignedLongValue];
}

- (long)nx_longValue
{
    NX_CONVERT_USING(strtol);
}

- (unsigned long)nx_unsignedLongValue
{
    NX_CONVERT_USING(strtoul);
}

- (unsigned long long)nx_unsignedLongLongValue
{
    NX_CONVERT_USING(strtoull);
}

- (NSUInteger)nx_unsignedIntegerValue
{
    return (NSUInteger)[self nx_unsignedLongValue];
}

- (NSNumber *)nx_numberValue
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [formatter numberFromString:self];
}

- (BOOL)nx_onlyContainsNumbers {
    NSCharacterSet *_NumericOnly = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *myStringSet = [NSCharacterSet characterSetWithCharactersInString:self];

    return ([_NumericOnly isSupersetOfSet: myStringSet]);
}

- (NSArray *)nx_arrayValue
{
    return [NSArray arrayWithObject:self];
}

- (NSDictionary *)nx_dictionaryValue
{
    return [self propertyList];
}

- (NSData *)nx_dataValue
{
    return [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
}

- (NSDecimal)nx_decimalValue
{
    return [[NSDecimalNumber decimalNumberWithString:self] decimalValue];
}

- (NSDecimalNumber *)nx_decimalNumberValue
{
    return [NSDecimalNumber decimalNumberWithString:self];
}

- (NSString *)nx_firstNumberStr {
    NSMutableString *strippedString= @"".mutableCopy;
    for (int i=0; i<[self length]; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isdigit(ch) || ch == '.' || ch == '-') {
            [strippedString appendFormat:@"%c",[self characterAtIndex:i]];
        } else if (strippedString.length > 0) {
            break;
        }
    }
    return strippedString;
}

- (NSURL *)nx_urlValue
{
    if (!self || self.length == 0) {
        return [NSURL URLWithString:self];
    }
    return nil;
}

- (NSURL *)nx_urlUTF8Value {
    NSURL *url = self.nx_urlValue;
    if (url) {
        return url;
    }
    if (!self || self.length == 0) {
        return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return nil;
}

- (NSString *)nx_trim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)nx_md5
{
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return hash;
}

- (NSString *)nx_SHA256 {
    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

- (NSString *)nx_stringByUrlEncoding
{
    return [self nx_stringByUrlEncoding:kCFStringEncodingUTF8];
}

- (NSString *)nx_appendQueryString:(NSString *)queryString {
    if (![queryString length]) {
            return self;
        }
    return [NSString stringWithFormat:@"%@%@%@", self,
            [self rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
}

- (NSString *)nx_stringByUrlEncoding:(CFStringEncoding)encoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", encoding));
}

- (NSString *)nx_stringByUrlDecode
{
    return [self nx_stringByUrlDecode:NSUTF8StringEncoding];
}

- (NSString *)nx_stringByUrlDecode:(NSStringEncoding)encoding
{
    return [self stringByReplacingPercentEscapesUsingEncoding:encoding];
}

- (NSDictionary *)nx_stringByUrlParameterDictionary
{
    NSMutableDictionary *result = nil;
    if (!self || self.length == 0) {
        result = [NSMutableDictionary dictionary];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
        NSScanner *scanner = [[NSScanner alloc] initWithString:self];
        while (![scanner isAtEnd]) {
            NSString *string = nil;
            [scanner scanUpToCharactersFromSet:characterSet intoString:&string];
            [scanner scanCharactersFromSet:characterSet intoString:NULL];
            NSArray *keyValue = [string componentsSeparatedByString:@"="];
            if ([keyValue count] == 2) {
                NSString *key = [[keyValue nx_stringAtIndex:0] nx_stringByUrlDecode];
                NSString *value = [[keyValue nx_stringAtIndex:1] nx_stringByUrlDecode];
                [result nx_setObjectCheck:value forKey:key];
            }
        }
    }
    return result;
}

- (NSString *)nx_formatTimestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSString *timeStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    NSString* strDate = [formatter stringFromDate:date];
    return strDate;
}

- (NSString *)nx_formatCommentTimestamp {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSString *timeStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSTimeInterval commentTime = [[NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue] timeIntervalSince1970];
    NSTimeInterval time = currentTime - commentTime;
    NSString *strTime = @"";
    if (time < 60) {
        strTime = @"刚刚";
    } else if (time < 3600) {
        strTime = [NSString stringWithFormat:@"%d分钟前", (int)time / 60];
    } else if (time < 86400) {
        strTime = [NSString stringWithFormat:@"%d小时前", (int)time / 3600];
    } else {
        strTime = [NSString stringWithFormat:@"%d天前", (int)time / 86400];
    }
    return strTime;
}

- (NSString *)nx_substringWithRangeCheck:(NSRange)range
{
    NSUInteger length = [self length];
    if (range.location >= length) {
        return @"";
    }
    if (range.location + range.length > length) {
        NSUInteger len = length - range.location;
        range.length = len;
    }
    return [self substringWithRange:range];
}

- (NSString *)nx_stringByRever
{
    NSUInteger len = [self length];
    if (len == 0) {
        return @"";
    }
    
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:len];
    for(NSUInteger i = len-1; i > 0; i--) {
        [result appendString:[NSString stringWithFormat:@"%c",[self characterAtIndex:i]]];
    }
    return result;
}

+ (NSInteger)nx_apivNumberFromAPIVString:(NSString *)apiv {
    NSArray *arr = [apiv componentsSeparatedByString:@"."];
    NSInteger apivCount = 0;
    
    NSInteger k = 0;
    while (k < [arr count]) {
        apivCount += [[arr objectAtIndex:k] integerValue] * pow(10, ([arr count] - k - 1));
        k++;
    }
    
    return apivCount;
}



- (NSString*)nx_stringByUnescapingFromURLArgument
{
    NSMutableString *resultString = [NSMutableString stringWithString:self];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    return [resultString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)nx_fileMD5HashCreateWithPath:(NSString *)filePath {
    if (!filePath) {
        return nil;
    }
    
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[4096];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,
                      (const void *)buffer,
                      (CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,
                                       (const char *)hash,
                                       kCFStringEncodingUTF8);
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    
    return (__bridge NSString *)(result);
}

- (NSString *)nx_appIdString {
    NSString *appID = nil;
    NSRange wholeRange;
    wholeRange.location = 0;
    wholeRange.length = [self length];
    
    NSRegularExpression *exp = [[NSRegularExpression alloc] initWithPattern:@"id([\\d]+).*" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *appIDArr = [exp matchesInString:self options:NSMatchingReportCompletion range:wholeRange];
    if (appIDArr != nil && [appIDArr count] > 0)
    {
        NSTextCheckingResult *appIDResult = [appIDArr nx_objectAtIndexCheck:0];
        if ([appIDResult numberOfRanges] <= 1)
        {
            return nil;
        }
        appID = [self substringWithRange:[appIDResult rangeAtIndex:1]];
    }
    
    return appID;
}

- (NSDictionary*)nx_convertToDictionary {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)nx_substringFromIndexSafely:(NSInteger)atIndex
{
    if (self.length > atIndex) {
        return [self substringFromIndex:atIndex];
    }
    return self;
}

- (NSString *)nx_checkLegalCharacterUrlString {
    //提示 标签不能输入特殊字符
    NSString *predicateStr =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateStr];
    
    if (![predicate evaluateWithObject:self]) {
        return self;
    }
    
    NSString *codeString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return codeString;
}

+ (BOOL)nx_checkHasChinese:(NSString *)string {
    for (int i = 0;i<string.length;i++) {
        unichar ch = [string characterAtIndex:i];
        if (0x4E00 <= ch && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)nx_disableEmoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (CGFloat)nx_heightWithFont:(UIFont *)font Width:(float)width
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    
    return ceil(textRect.size.height);
}
- (CGFloat)nx_widthWithFont:(UIFont *)font
{
    CGRect textRect = CGRectZero;
    textRect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:font}
                                  context:nil];
    
    return ceil(textRect.size.width);
}

- (NSInteger)nx_stringLinesWithFont:(UIFont *)font width:(CGFloat)width {
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize stringSize = CGSizeZero;
    stringSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                    options:options
                                 attributes:@{NSFontAttributeName:font} context:nil].size;
    
    if (self.length == 0) {
        return 0;
    }
    return ceilf(stringSize.height/([@"Sample样本" boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                              options:options
                                                           attributes:@{NSFontAttributeName:font} context:nil].size.height));
}

- (int)nx_textLength {
    CGFloat asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 0.5 : 1;
    }
    CGFloat unicodeLength = asciiLength;
    return (int)unicodeLength;
    
}

+ (NSString *)nx_WiFiMacAddress {
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        if (info && [info count]) break;
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *bssid = [dic objectForKey:@"BSSID"];
    return bssid;
}

+ (NSString *)nx_WifiName {
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        if (info && [info count]) break;
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *ssid = [[dic objectForKey:@"SSID"] lowercaseString];
    return ssid;
}

- (BOOL)nx_checkHasEmoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger result = [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return result;
}

- (NSAttributedString *)nx_attributeStringShadowWithShadowBlur:(CGFloat)blur shadowColor:(UIColor *)color {
    return [self nx_attributeStringShadowWithShadowBlur:blur shadowOffset:CGSizeZero shadowColor:color shadowRange:NSMakeRange(0, self.length)];
}

- (NSAttributedString *)nx_attributeStringShadowWithShadowBlur:(CGFloat)blur shadowOffset:(CGSize)offset shadowColor:(UIColor *)color shadowRange:(NSRange)range {
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:self];
    if (color == nil || !NSLocationInRange(range.location, NSMakeRange(0, self.length)) || NSMaxRange(range) > self.length) return attributes;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = blur;
    shadow.shadowOffset = offset;
    shadow.shadowColor = color;
    [attributes addAttribute:NSShadowAttributeName
                       value:shadow
                       range:range];
    return attributes;
}

- (NSComparisonResult)nx_compareVersion:(NSString *)string
{
    NSString *ver1 = self;
    NSString *ver2 = string;
    
    //qfy copy from google GTL https://github.com/brynbellomy/iOS-GTLYouTube/tree/master/Utilities
    
    static NSCharacterSet* dotSet = nil;
    if (dotSet == nil) {
        dotSet = [NSCharacterSet characterSetWithCharactersInString:@"."];
    }
    
    if (ver1 == nil) ver1 = @"";
    if (ver2 == nil) ver2 = @"";
    
    NSScanner* scanner1 = [NSScanner scannerWithString:ver1];
    NSScanner* scanner2 = [NSScanner scannerWithString:ver2];
    
    [scanner1 setCharactersToBeSkipped:dotSet];
    [scanner2 setCharactersToBeSkipped:dotSet];
    
    int partA1 = 0, partA2 = 0, partB1 = 0, partB2 = 0;
    int partC1 = 0, partC2 = 0, partD1 = 0, partD2 = 0;
    
    if ([scanner1 scanInt:&partA1] && [scanner1 scanInt:&partB1]
        && [scanner1 scanInt:&partC1] && [scanner1 scanInt:&partD1]) {
    }
    if ([scanner2 scanInt:&partA2] && [scanner2 scanInt:&partB2]
        && [scanner2 scanInt:&partC2] && [scanner2 scanInt:&partD2]) {
    }
    
    if (partA1 != partA2) return ((partA1 < partA2) ? NSOrderedAscending : NSOrderedDescending);
    if (partB1 != partB2) return ((partB1 < partB2) ? NSOrderedAscending : NSOrderedDescending);
    if (partC1 != partC2) return ((partC1 < partC2) ? NSOrderedAscending : NSOrderedDescending);
    if (partD1 != partD2) return ((partD1 < partD2) ? NSOrderedAscending : NSOrderedDescending);
    
    return NSOrderedSame;
}

//普通字符串转换为十六进制的。

- (NSString *)nx_hexStringFromString{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


// 十六进制转换为普通字符串的。
- (NSString *)nx_stringFromHexString {
    
    char *myBuffer = (char *)malloc((int)[self length] / 2 + 1);
    bzero(myBuffer, [self length] / 2 + 1);
    for (int i = 0; i < [self length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [self substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    free(myBuffer);
    return unicodeString;
}

-(BOOL)startWithEmoji{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSRange range = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return  range.location == 0;
}

-(NSString *)firstCharOrEmojiIfNeed{
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    NSRange range = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if ([self startWithEmoji] && [self substringWithRange:range]) {
        return  [self substringWithRange:range];
    }
    if (self.nx_trim.length > 0) {
        return  [self.nx_trim substringToIndex:1];
    } else {
        return @"";
    }
}

+(NSString *)nx_uuidString {
    return NSUUID.UUID.UUIDString.lowercaseString;
}

- (NSString *)SHA256Base64
{
    NSString *data = @"";
    const char *cKey  = [self cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);

    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    return [HMAC base64Encoding];
}


- (NSArray *)rangeOfSubString:(NSString *)subStr{
    //关键字本身就比内容长  直接返回空数组
    if (subStr.length > self.length) {
        return [NSMutableArray array];
    }
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString *temp;
    for (int i = 0; i < self.length; i ++) {
        //筛选的字段比剩下的字段还要长  不用再检索了
        if (subStr.length + i > self.length) {
            break;
        }
        temp = [self nx_substringWithRangeCheck:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject:NSStringFromRange(range)];
        }
    }
    return rangeArray;
}

@end
