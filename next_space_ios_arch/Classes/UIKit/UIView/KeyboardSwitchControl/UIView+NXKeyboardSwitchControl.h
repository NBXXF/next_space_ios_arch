//
//  UIView+NXKeyboardSwitchControl.h
//  next_space_ios_arch
//  上下滑动自动关闭键盘
//  Created by XXF on 2023/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(NXKeyboardSwitchControl)

/**
 是否运行滑动关闭键盘,管理键盘关闭
 键盘处理,自动处理键盘关闭
 互动关闭键盘
 */
@property(nonatomic,assign)BOOL allowSlideToCloseKeyboard;
@end

NS_ASSUME_NONNULL_END
