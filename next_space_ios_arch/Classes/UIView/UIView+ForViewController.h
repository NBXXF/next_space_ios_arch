//
//  UIView+ForViewController.h
//  JLRoutes
//
//  Created by XXF on 2022/10/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(ForViewController)

/**
 找到最近的viewcontroller,不能在new 等没有显示出来的生命周期去访问
 */
- (UIViewController * __nullable)findViewController;

/**
  向上查找对应的view
 */
- (UIView *)findSuperViewWithClass:(Class)superClazz;

/**
  向上查找对应的view
 */
- (UIView *)findSuperViewWithBlock:(BOOL (^)(UIView *superView))block;

/**
 查找当前有焦点的组件
 */
- (UIView <UIKeyInput> *)findFocusedTextInput;

/**
 查找第一个能获取焦点的组件
 */
- (UIView <UIKeyInput> *)findTextInput;
@end

NS_ASSUME_NONNULL_END
