//
//  NSAttributedString+NXUtil.h
//  NXFundation
//
//  Created by jsonLee on 2021/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (NXUtil)
/*!
 @method substringFromIndexSafely
 @abstract 检测是否在合法范围内，在就返回字符
 @param atIndex 位置
 @result 返回NSString
 */
- (NSAttributedString *)nx_subAttStringFromIndexSafely:(NSInteger)atIndex;
/*!
 @method substringWithRangeCheck:
 @abstract 检测是否在合法范围内，在就返回字符
 @param range 截取范围
 @result 返回NSString
 */
- (NSAttributedString *)nx_subAttStringWithRangeCheck:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
