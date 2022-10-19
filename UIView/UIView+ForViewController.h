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
@end

NS_ASSUME_NONNULL_END
