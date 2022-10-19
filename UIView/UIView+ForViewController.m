//
//  UIView+ForViewController.m
//  JLRoutes
//
//  Created by XXF on 2022/10/19.
//

#import "UIView+ForViewController.h"

@implementation UIView(ForViewController)

- (UIViewController *)findViewController{
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
