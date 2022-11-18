//
//  UIApplication+NXTools.h
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication(NXTools)

/**
 顶部状态栏高度
 */
- (CGFloat)topLayoutOffset;

/**
 底部导航条高度
 */
- (CGFloat)bottomLayoutOffset;

@end

NS_ASSUME_NONNULL_END
