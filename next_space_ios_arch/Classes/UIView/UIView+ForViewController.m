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


- (UIView *)findSuperViewWithClass:(Class)superClazz{
    return [self findSuperViewWithBlock:^BOOL(UIView * _Nonnull superView) {
        return superView.class==superClazz;
    }];
}


- (UIView *)findSuperViewWithBlock:(BOOL (^)(UIView * _Nonnull))block{
    UIView *superView=self.superview;
    while (superView) {
        if(block(superView)){
            return superView;
        }
        superView=superView.superview;
    }
    return nil;
}


- (UIView<UIKeyInput> *)findFocusedTextInput{
    return [self findCurrentTextInputInView:self];
}


- (UIView <UIKeyInput> *)findCurrentTextInputInView:(UIView *)view {
    if ([view conformsToProtocol:@protocol(UIKeyInput)] && view.isFirstResponder) {
        // Quick fix for web view issue
        if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")] || [view isKindOfClass:NSClassFromString(@"WKContentView")]) {
            return nil;
        }
        return (UIView <UIKeyInput> *) view;
    }

    for (UIView *subview in view.subviews) {
        UIView <UIKeyInput> *inputInView = [self findCurrentTextInputInView:subview];
        if (inputInView) {
            return inputInView;
        }
    }
    return nil;
}

- (UIView<UIKeyInput> *)findTextInput{
    return [self findTextInputInView:self];
}


- (UIView<UIKeyInput> *)findTextInputInView:(UIView *)view{
    if ([view conformsToProtocol:@protocol(UIKeyInput)]) {
        // Quick fix for web view issue
        if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")] || [view isKindOfClass:NSClassFromString(@"WKContentView")]) {
            return nil;
        }
        return (UIView <UIKeyInput> *) view;
    }

    for (UIView *subview in view.subviews) {
        UIView <UIKeyInput> *inputInView = [self findTextInputInView:subview];
        if (inputInView) {
            return inputInView;
        }
    }
    return nil;
}



@end
