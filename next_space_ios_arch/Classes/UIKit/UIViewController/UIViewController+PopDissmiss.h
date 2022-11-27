//
//  UIViewController+ShowDissmiss.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(PopDissmiss)

/**
 自动处理返回 不论是push出来 还是pop出来的 等价popOrDismissViewControllerAnimated
 */
-(void)backViewControllerAnimated:(BOOL)anim completion:(void (^ __nullable)(void))completion;

/**
 自动处理返回 不论是push出来 还是pop出来的 等价backViewControllerAnimated
 */
-(void)popOrDismissViewControllerAnimated:(BOOL)anim completion:(void (^ __nullable)(void))completion;

/**
 完全结束导航,不论是push出来(关闭整个导航) 还是pop出来的(直接关闭自己)
 */
-(void)finishNavigationControllerAnimated:(BOOL)anim completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
