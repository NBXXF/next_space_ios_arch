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

- (UIView *)findYoungerBrotherView{
    NSArray<__kindof UIView *> *subViews=  self.superview.subviews;
    NSInteger newLocation=[subViews indexOfObject:self]+1;
    if(subViews.count>newLocation){
        return [subViews objectAtIndex:newLocation];
    }
    return nil;
}


- (UIView *)findOlderBrotherView{
    NSArray<__kindof UIView *> *subViews=  self.superview.subviews;
    NSInteger newLocation=[subViews indexOfObject:self]-1;
    if(newLocation>=0){
        return [subViews objectAtIndex:newLocation];
    }
    return nil;
}


- (UIView *)findFirstChildViewWithBlock:(BOOL (^)(UIView * _Nonnull))block deepQuery:(BOOL)deepQuery{
    NSArray<__kindof UIView *> *subViews=  self.subviews;
    if(deepQuery){
        for(UIView *child in subViews){
            UIView *find= [self findDeepFirstChildViewWithBlock:block parent:child];
            if(find){
                return find;
            }
        }
    }else{
        for(UIView *child in subViews){
            if(block(child)){
                return child;
            }
        }
    }
    return nil;
}

- (UIView *)findDeepFirstChildViewWithBlock:(BOOL (^)(UIView * _Nonnull))block parent:(UIView *)parent{
    if(block(parent)){
        return parent;
    }
    NSArray<__kindof UIView *> *subViews=  parent.subviews;
    for(UIView *child in subViews){
        UIView *find= [self findDeepFirstChildViewWithBlock:block parent:child];
        if(find){
            return find;
        }
    }
    return nil;
}

- (UIView<UIKeyInput> *)findFirstFocusedTextInput{
    return (UIView<UIKeyInput> *)[self findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
        if ([childView conformsToProtocol:@protocol(UIKeyInput)]&& childView.isFirstResponder) {
            // Quick fix for web view issue
            if ([childView isKindOfClass:NSClassFromString(@"UIWebBrowserView")] || [childView isKindOfClass:NSClassFromString(@"WKContentView")]) {
                return NO;
            }
            return YES;
        }
        return NO;
    } deepQuery:YES];
}

- (UIView<UIKeyInput> *)findFirstTextInput{
    return (UIView<UIKeyInput> *)[self findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
        if ([childView conformsToProtocol:@protocol(UIKeyInput)]) {
            // Quick fix for web view issue
            if ([childView isKindOfClass:NSClassFromString(@"UIWebBrowserView")] || [childView isKindOfClass:NSClassFromString(@"WKContentView")]) {
                return NO;
            }
            return YES;
        }
        return NO;
    } deepQuery:YES];
}



@end
