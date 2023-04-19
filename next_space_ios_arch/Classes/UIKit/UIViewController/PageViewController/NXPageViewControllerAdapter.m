//
//  UIPageViewControllerAdapter.m
//  next_space_ios_arch
//  简化tab组件
//  Created by XXF on 2023/4/19.
//

#import "NXPageViewControllerAdapter.h"
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <next_space_ios_arch/NSObject+NXAssociation.h>
@interface NXPageViewControllerAdapter()
@property (assign, nonatomic) NSInteger currentIndex;
@property(nonatomic,strong) NSArray<UIViewController *> *controllers;
@end
@implementation NXPageViewControllerAdapter


- (NSString *)keyTabIndex{
    return [NSString stringWithFormat:@"%@_keyTabIndex",__FILE_LINE__];
}

- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)controllers{
    self=[self init];
    if(self){
        self.controllers=controllers;
    }
    return self;
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    NSInteger currentIndex=[[pageViewController.viewControllers.firstObject nx_getAssociatedObject:self.keyTabIndex] integerValue];
    
    //滑动了 更新选中
    self.currentIndex=currentIndex;
}


#pragma mark 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger currentIndex=[[viewController nx_getAssociatedObject:self.keyTabIndex] integerValue];
    NSInteger willIndex=currentIndex-1;
    return [[self pageViewController:pageViewController viewController:viewController atIndex:willIndex] applyWithBlock:^(UIViewController *_Nonnull it) {
        [it nx_setAssociatedObject:@(willIndex) forKey:self.keyTabIndex policy:NX_ASSOCIATION_ASSIGN];
    }];
}


#pragma mark 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger currentIndex=[[viewController nx_getAssociatedObject:self.keyTabIndex] integerValue];
    NSInteger willIndex=currentIndex+1;
    return [[self pageViewController:pageViewController viewController:viewController atIndex:willIndex] applyWithBlock:^(UIViewController *_Nonnull it) {
        [it nx_setAssociatedObject:@(willIndex) forKey:self.keyTabIndex policy:NX_ASSOCIATION_ASSIGN];
    }];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewController:(UIViewController *)viewController atIndex:(NSInteger)atIndex{
    UIViewController *childPageVC = self.controllers[atIndex];
    return childPageVC;
}
@end
