//
//  UIView+ForViewController.m
//  JLRoutes
//
//  Created by XXF on 2022/10/19.
//

#import "UIView+SuperTools.h"

@implementation UIView(SuperTools)

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


- (NSArray<UIView *> *)findSortedSubviews{
    //不考虑重复叠层的情况
    return [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView *  _Nonnull obj1, UIView *  _Nonnull obj2) {
    
        CGPoint obj1Point=[obj1 convertPointToWindow];
        CGPoint obj2Point=[obj2 convertPointToWindow];
        
         if (obj1Point.x<obj2Point.x){
             if(obj1Point.y<obj2Point.y){
                 return NSOrderedAscending;
             }else{
                 return NSOrderedDescending;
             }
         }else{
             if(obj1Point.y<obj2Point.y){
                 return NSOrderedAscending;
             }else{
                 return NSOrderedDescending;
             }
         }
         return NSOrderedAscending;
    }];
}


- (CGPoint)convertPointToWindow{
    CGPoint selfPoint=[self convertPoint:self.frame.origin toView:self.window];
    return selfPoint;
}

- (BOOL)isLeftForView:(UIView *)target{
    CGPoint selfPoint=[self convertPointToWindow];
    CGPoint targetPoint=[target convertPointToWindow];
    return selfPoint.x<targetPoint.x;
}


- (BOOL)isRightForView:(UIView *)target{
    CGPoint selfPoint=[self convertPointToWindow];
    CGPoint targetPoint=[target convertPointToWindow];
    return selfPoint.x>targetPoint.x;
}


- (BOOL)isUpForView:(UIView *)target{
    CGPoint selfPoint=[self convertPointToWindow];
    CGPoint targetPoint=[target convertPointToWindow];
    return selfPoint.y<targetPoint.y;
}


- (BOOL)isDownForView:(UIView *)target{
    CGPoint selfPoint=[self convertPointToWindow];
    CGPoint targetPoint=[target convertPointToWindow];
    return selfPoint.y>targetPoint.y;
}


- (UIView *)findYoungerBrotherView{
    NSArray<__kindof UIView *> *subViews=  [self.superview findSortedSubviews];
    NSInteger newLocation=[subViews indexOfObject:self]+1;
    if(subViews.count>newLocation){
        return [subViews objectAtIndex:newLocation];
    }
    return nil;
}


- (UIView *)findOlderBrotherView{
    NSArray<__kindof UIView *> *subViews=  [self.superview findSortedSubviews];
    NSInteger newLocation=[subViews indexOfObject:self]-1;
    if(newLocation>=0){
        return [subViews objectAtIndex:newLocation];
    }
    return nil;
}

/**
 查询第一个满足条件的
 */
- (UIView *)findFirstChildViewWithBlock:(BOOL (^)(UIView * _Nonnull))block deepQuery:(BOOL)deepQuery{
    NSArray<__kindof UIView *> *subViews=  [self findSortedSubviews];
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

/**
 查询最后一个满足条件的
 */
- (UIView *)findLastChildViewWithBlock:(BOOL (^)(UIView * _Nonnull))block deepQuery:(BOOL)deepQuery{
    return [self findChildViewWithBlock:block deepQuery:deepQuery].lastObject;
}


/**
 查询满足条件的
 */
- (NSArray<UIView *> *)findChildViewWithBlock:(BOOL (^)(UIView * _Nonnull))block deepQuery:(BOOL)deepQuery{
    NSMutableArray<UIView *> *queryResult=[NSMutableArray array];
    NSArray<__kindof UIView *> *subViews=  [self findSortedSubviews];
    if(deepQuery){
        for(UIView *child in subViews){
            [queryResult addObjectsFromArray:[self findChildViewWithBlock:block parent:child]];
        }
    }else{
        for(UIView *child in subViews){
            if(block(child)){
                [queryResult addObject:child];
            }
        }
    }
    return queryResult;
}


- (UIView *)findDeepFirstChildViewWithBlock:(BOOL (^)(UIView * _Nonnull))block parent:(UIView *)parent{
    if(block(parent)){
        return parent;
    }
    NSArray<__kindof UIView *> *subViews=  [parent findSortedSubviews];
    for(UIView *child in subViews){
        UIView *find= [self findDeepFirstChildViewWithBlock:block parent:child];
        if(find){
            return find;
        }
    }
    return nil;
}


- (NSArray<UIView *> *)findChildViewWithBlock:(BOOL (^)(UIView * _Nonnull))block parent:(UIView *)parent{
    NSMutableArray<UIView *> *queryResult=[NSMutableArray array];
    if(block(parent)){
        [queryResult addObject:parent];
    }
    NSArray<__kindof UIView *> *subViews=  [parent findSortedSubviews];
    for(UIView *child in subViews){
        [queryResult addObjectsFromArray:[self findChildViewWithBlock:block parent:child]];
    }
    return queryResult;
}



- (BOOL)isTextInputView{
    UIView *childView=self;
    if ([childView conformsToProtocol:@protocol(UITextInput)]) {
        // Quick fix for web view issue
        if ([childView isKindOfClass:NSClassFromString(@"UIWebBrowserView")] || [childView isKindOfClass:NSClassFromString(@"WKContentView")]) {
            return NO;
        }
        return YES;
    }
    return NO;
}


- (UIView<UITextInput> *)findFirstFocusedTextInput{
    return (UIView<UITextInput> *)[self findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
        return [childView isTextInputView] && childView.isFirstResponder;
    } deepQuery:YES];
}

- (UIView<UITextInput> *)findFirstTextInput{
    return (UIView<UITextInput> *)[self findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
        return [childView isTextInputView];
    } deepQuery:YES];
}



@end
