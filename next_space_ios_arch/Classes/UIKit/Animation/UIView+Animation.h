//
//  UIView+Animation.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/25.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import <pop/pop-umbrella.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(Animation)
/**
 是否允许高亮时候执行默认动画
 */
@property(nonatomic,assign)BOOL allowAnimationForHighlight;
-(NSString *)_keyAllowAnimationForHighlight;

-(void)animateWithBounce;
@end

NS_ASSUME_NONNULL_END
