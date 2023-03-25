//
//  UIView+swizzleFrame.h
//  next_space
//
// 应为M1 ipad 不支持设置 autocorrectionType saveWindowFrame 会设置一个Null 导致崩溃  但是 autocorrectionType 是协议属性不好拦截 这里直接拦截setFrame

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SwizzleFrame)

@end

NS_ASSUME_NONNULL_END
