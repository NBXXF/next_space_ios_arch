//
//  UIViewController+NXQuery.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(NXQuery)

/**
  向上查找对应的ParentViewController
 */
- (UIViewController * __nullable)findParentViewControllerWithClass:(Class)parentViewControllerClazz;

/**
  向上查找对应的ParentViewController
 */
- (UIViewController * __nullable)findParentViewControllerWithBlock:(BOOL (^)(UIViewController *parentViewController))block;

@end

NS_ASSUME_NONNULL_END
