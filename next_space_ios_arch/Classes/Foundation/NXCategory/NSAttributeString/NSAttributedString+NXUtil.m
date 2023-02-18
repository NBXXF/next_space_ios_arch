//
//  NSAttributedString+NXUtil.m
//  NXFundation
//
//  Created by jsonLee on 2021/8/24.
//

#import "NSAttributedString+NXUtil.h"

@implementation NSAttributedString (NXUtil)
/*!
 @method substringFromIndexSafely
 @abstract 检测是否在合法范围内，在就返回字符
 @param atIndex 位置
 @result 返回NSString
 */
- (NSAttributedString *)nx_subAttStringFromIndexSafely:(NSInteger)atIndex{
    if (self.string.length > atIndex) {
        return [self attributedSubstringFromRange:NSMakeRange(atIndex, self.string.length - atIndex)];
    }
    return nil;
}
/*!
 @method substringWithRangeCheck:
 @abstract 检测是否在合法范围内，在就返回字符
 @param range 截取范围
 @result 返回NSString
 */
- (NSAttributedString *)nx_subAttStringWithRangeCheck:(NSRange)range{
    NSUInteger length = [self.string length];
    if (range.location >= length) {
        return nil;
    }
    if (range.location + range.length > length) {
        NSUInteger len = length - range.location;
        range.length = len;
    }
    return [self attributedSubstringFromRange:range];
}

@end
