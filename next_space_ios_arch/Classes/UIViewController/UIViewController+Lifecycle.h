//
//  UIViewController+Lifecycle.h
//  next_space_ios_arch
//   生命周期
//  Created by XXF on 2022/10/12.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(Lifecycle)
/**
 加载完毕，能够进行自己定义数据以及动态创建其它控件
 */
- (RACSignal *)observeViewDidLoad;

/**
 视图将出如今屏幕之前，立即这个视图就会被展如今屏幕上了
 */
- (RACSignal *)observeViewWillAppear;

/**
 视图已在屏幕上渲染完毕
 */
- (RACSignal *)observeViewDidAppear;

/**
 视图将被从屏幕上移除之前运行
 **/
- (RACSignal *)observeViewWillDisappear;

/**
 视图已经被从屏幕上移除，用户看不到这个视图了
 */
- (RACSignal *)observeViewDidDisappear;
@end

NS_ASSUME_NONNULL_END
