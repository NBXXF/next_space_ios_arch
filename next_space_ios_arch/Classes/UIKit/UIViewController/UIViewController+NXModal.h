//
//  UIViewController+NXDebounce.h
//  next_space_ios_arch
//  弹窗限流,全局hook,避免有些组件没有继承关系
//  Created by XXF on 2023/3/22.
//

#import <UIKit/UIKit.h>
@class Presentr;
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(NXModal)
/**
 增加modal相关的样式属性配置
 */
@property(nonatomic,strong,nullable) Presentr *modalPresentationConfig;
@end

NS_ASSUME_NONNULL_END
