//
//  UIPageViewController+NXAdapter.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/4/19.
//

#import "UIPageViewController+NXAdapter.h"
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <next_space_ios_arch/UIView+NXQuery.h>

@implementation UIPageViewController(NXAdapter)
- (NXPageViewControllerAdapter *)adapter{
    return [NXPageViewControllerAdapter  toKindOfClassObjectOrNilFrom:self.dataSource];
}
- (void)setAdapter:(NXPageViewControllerAdapter *)adapter{
    self.dataSource=adapter;
    self.delegate=adapter;
}

- (BOOL)isPagingEnabled{
    UIScrollView *scrollView=(UIScrollView *)[self.view findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
        return [childView isKindOfClass:UIScrollView.class];
    } deepQuery:YES];
    return scrollView.isScrollEnabled;
}
- (void)setIsPagingEnabled:(BOOL)isPagingEnabled{
    UIScrollView *scrollView=(UIScrollView *)[self.view findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
        return [childView isKindOfClass:UIScrollView.class];
    } deepQuery:YES];
    [scrollView setScrollEnabled:isPagingEnabled];
}
@end
