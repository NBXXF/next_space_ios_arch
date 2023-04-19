//
//  UIPageViewController+NXAdapter.h
//  next_space_ios_arch
//
//  Created by XXF on 2023/4/19.
//

#import <next_space_ios_arch/NXPageViewControllerAdapter.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIPageViewController(NXAdapter)
@property(nonatomic,strong) NXPageViewControllerAdapter *adapter;
@property(nonatomic,assign) BOOL isPagingEnabled;
@end

NS_ASSUME_NONNULL_END
