//
//  UIControl+Animation.h
//  next_space_ios_arch
//  为UIControl 增加默认的动画
//  Created by XXF on 2023/3/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl(Animation)
/**
 是否允许高亮时候执行默认动画
 */
@property(nonatomic,assign)BOOL allowAnimationForHighlight;
@end

NS_ASSUME_NONNULL_END
