//
//  NXViewController.h
//  next_space_ios_arch
//  处理基类,做框架层使用,现在很多组件hook生命周期的 冲突很多,现在得基于继承上来做
//  Created by XXF on 2022/11/3.
//

#import <Foundation/Foundation.h>
#import "NXUIComponentProtocol.h"
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface NXViewController :UIViewController<NXUIComponentProtocol>
/**
 * 用于承载内容,业务组件都应该添加于此
 */
@property (nonatomic, strong) UIView *contentView;


@end

NS_ASSUME_NONNULL_END
