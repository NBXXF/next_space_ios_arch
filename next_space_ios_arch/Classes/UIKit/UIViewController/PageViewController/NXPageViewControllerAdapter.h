//
//  UIPageViewControllerAdapter.h
//  next_space_ios_arch
// 简化tab组件
//  Created by XXF on 2023/4/19.
//


NS_ASSUME_NONNULL_BEGIN

@interface NXPageViewControllerAdapter : NSObject<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (assign, nonatomic,readonly) NSInteger currentIndex;
@property(nonatomic,strong,readonly)NSString *keyTabIndex;


- (instancetype)initWithViewControllers:(NSArray<UIViewController *> *)controllers;



#pragma mark 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController DEPRECATED_MSG_ATTRIBUTE("过时了,请使用pageViewController:viewController:atIndex");


#pragma mark 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController DEPRECATED_MSG_ATTRIBUTE("过时了,请使用pageViewController:viewController:atIndex");

#pragma mark 返回对应位置的ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewController:(UIViewController *)viewController
                               atIndex:(NSInteger)atIndex;
@end

NS_ASSUME_NONNULL_END
