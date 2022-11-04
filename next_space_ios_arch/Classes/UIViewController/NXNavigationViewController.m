//
//  NXNavigationViewController.m
//  next_space_ios_arch
//  处理基类,做框架层使用,现在很多组件hook生命周期的 冲突很多,现在得基于继承上来做
//  Created by XXF on 2022/11/3.
//

#import "NXNavigationViewController.h"

@implementation NXNavigationViewController

/**
 特殊标记系统方法废弃
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated DEPRECATED_MSG_ATTRIBUTE("为了组件复用,请直接使用分类拓展popOrDismissViewControllerAnimated或者finishNavigationControllerAnimated方法"){
    return [super popViewControllerAnimated:animated];
}
@end
