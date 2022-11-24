//
//  UIView+NXStatus.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(NXStatus)
/*
 enabled 和UIControl定义字段冲突
 是否是禁用状态
 */
@property(nonatomic,assign) BOOL disabled;

@end

NS_ASSUME_NONNULL_END
