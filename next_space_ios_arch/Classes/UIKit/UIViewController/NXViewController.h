//
//  NXViewController.h
//  next_space_ios_arch
//  处理基类,做框架层使用,现在很多组件hook生命周期的 冲突很多,现在得基于继承上来做
//  Created by XXF on 2022/11/3.
//

#import <Foundation/Foundation.h>
#import "NXUIComponentProtocol.h"
#import <UIKit/UIKit.h>
#import "UIView+NXGestureRecognizer.h"
#import "NXRouterResultCallback.h"
#import "NXCommonResultProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NXViewController :UIViewController<NXUIComponentProtocol,NXCommonResultProtocol>

/**
 路由传过来的参数
 */
@property (nullable, strong, nonatomic) NSMutableDictionary * routerParams;

/**
 路由定义的回调
 */
@property (nonatomic,copy) NXRouterResultCallback kRouterResultCallback;


#if DEBUG
@property(null_resettable, nonatomic,strong) UIView *view DEPRECATED_MSG_ATTRIBUTE("请使用contentView");
#endif


/**
 * 背景组件,一般弹窗用 或者业务 可以自定义背景 如 `UIImageView`, `UIVisualEffectView`
 * 内部处理insert at 0;
 * 默认透明背景
 */
@property (nonatomic, strong) UIView *backgroundView;

/**
 * 用于承载内容,业务组件都应该添加于此
 * 只允许复写get方法
 * 默认白色背景
 */
@property (nonatomic, strong, readonly) UIView *contentView;

/**
 特殊标记系统方法废弃
 */
- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion DEPRECATED_MSG_ATTRIBUTE("为了组件复用,请直接使用分类拓展popOrDismissViewControllerAnimated或者finishNavigationControllerAnimated方法");

@end

NS_ASSUME_NONNULL_END
