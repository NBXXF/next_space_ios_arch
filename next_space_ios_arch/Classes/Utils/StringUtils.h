//
//  StringUtils.h
//  NXUIKit
//
//  Created by XXF on 2022/8/23.
//

#import <Foundation/Foundation.h>

#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqualToString:@""]) || ((_ref).length == 0))
#define IsRangeExist(_range) (_range.location != NSNotFound && _range.length >= 0)
#define safeStr(str) IsStrEmpty(str)? @"" : str

NS_ASSUME_NONNULL_BEGIN

@interface StringUtils : NSObject
+ (BOOL)isEmpty:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
