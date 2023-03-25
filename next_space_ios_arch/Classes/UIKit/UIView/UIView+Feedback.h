//
//  UIView+Vibrate.h
//  next_space_ios_arch
//  增加触觉反馈,震动反馈
//  Created by XXF on 2023/3/25.
//

/**
 学习整理
 FeedbackGenerator的子类
 1. UIImpactFeedbackGenerator. 使用碰撞反馈发生器来表明发生了碰撞。举个例子，
    当用户界面上的一个对象碰到什么东西、或者卡到某个地方的时候，触发碰撞反馈发生器。
 2. UISelectionFeedbackGenerator. 使用选择反馈发生器来表明选择状态发生了改变。
 3. UINotificationFeedbackGenerator. 使用通知反馈发生器来表明成功，失败，警告。
 */


#import <UIKit/UIKit.h>
#import <next_space_ios_arch/SingletonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/**
 触觉反馈工厂
 */
@interface ImpactFeedbackGenerator:NSObject
singleton_interface(ImpactFeedbackGenerator)
@property(nonatomic,strong) NSDictionary<NSNumber *,UIImpactFeedbackGenerator *> *feedbackGenerators;
@end




@interface UIView(Feedback)
/**
 是否允许触觉反馈
 */
@property(nonatomic,assign)BOOL allowFeedback;

/**
 触觉反馈样式
 */
@property(nonatomic,assign)UIImpactFeedbackStyle feedbackStyle;

/**
 准备触觉反馈
 */
-(void)prepareFeedback;

/**
 执行触觉反馈
 */
-(void)performFeedback;

@end


NS_ASSUME_NONNULL_END
