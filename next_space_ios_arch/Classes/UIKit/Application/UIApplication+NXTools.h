//
//  UIApplication+NXTools.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication(NXTools)
/**
 app的名称
 */
@property (nullable, nonatomic, readonly) NSString *appDisplayName;


/**
 获取最顶层Window
 */
- (UIWindow *)topWindow;

/**
 获取最顶层弹出来的vc,否则返回rootVC
 */
-(UIViewController *)topPresentedViewController;


/**
 顶部状态栏高度
 */
- (CGFloat)topLayoutOffset;

/**
 底部导航条高度
 */
- (CGFloat)bottomLayoutOffset;

@end

NS_ASSUME_NONNULL_END
