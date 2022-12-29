//
//  UIViewController+NXQuery.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import "UIViewController+NXQuery.h"

@implementation UIViewController(NXQuery)

- (UIViewController *)findParentViewControllerWithClass:(Class)parentViewControllerClazz{
    return [self findParentViewControllerWithBlock:^BOOL(UIViewController * _Nonnull parentViewController) {
        return parentViewControllerClazz==parentViewController.class;
    }];
}

- (UIViewController *)findParentViewControllerWithBlock:(BOOL (^)(UIViewController * _Nonnull))block{
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController != nil) {
        if(block(parentViewController)){
            return parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}
@end
