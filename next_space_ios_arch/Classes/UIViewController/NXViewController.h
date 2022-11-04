//
//  NXViewController.h
//  next_space_ios_arch
//  处理基类,做框架层使用,现在很多组件hook生命周期的 冲突很多,现在得基于继承上来做
//  Created by XXF on 2022/11/3.
//

#import <Foundation/Foundation.h>
#import "NXUIComponentProtocol.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NXViewController :UIViewController<NXUIComponentProtocol>
/**
 * 用于承载内容,业务组件都应该添加于此
 */
@property (nonatomic, strong) UIView *contentView;

/**
 特殊标记系统方法废弃
 */
- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion DEPRECATED_MSG_ATTRIBUTE("为了组件复用,请直接使用分类拓展popOrDismissViewControllerAnimated或者finishNavigationControllerAnimated方法");

@end

NS_ASSUME_NONNULL_END
