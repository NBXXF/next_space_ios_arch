//
//  UIComponentProtocol.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NXComponentGravity) {
    NXComponentGravityCenter=0,
    NXComponentGravityTop,
    NXComponentGravityBottom,
};

@protocol NXUIComponentProtocol <NSObject>

/**
 设置组件大小
 */
-(void)setComponentSize:(CGSize)size gravity:(NXComponentGravity)gravity DEPRECATED_MSG_ATTRIBUTE("过时了,用modalPresentationConfig字段");


/**
 设置组件透明度
 */
-(void)setComponentAlpha:(CGFloat)alpha DEPRECATED_MSG_ATTRIBUTE("过时了,用modalPresentationConfig字段");

/**
 设置组件背景色
 */
-(void)setComponentBackgroundColor:(UIColor *)color DEPRECATED_MSG_ATTRIBUTE("过时了,用modalPresentationConfig字段");

/**
 设置圆角
 */
-(void)setComponentCornerRadius:(CGFloat)radius DEPRECATED_MSG_ATTRIBUTE("过时了,用modalPresentationConfig字段");

/**
 设置阴影透明度
 */
-(void)setComponentShadowOpacity:(CGFloat)opacity DEPRECATED_MSG_ATTRIBUTE("过时了,用modalPresentationConfig字段");

/**
 点击外部是否可以取消
 */
-(void)setCanceledOnTouchOutside:(BOOL)cancel DEPRECATED_MSG_ATTRIBUTE("过时了,用modalPresentationConfig字段");


/**
 开启底部导航条安全区
 additionalSafeAreaInsets 没什么效果,据说带了导航控制器也不行,这里采用传统方式
 */
-(void)enableSafeAreaBottomInsets;

/**
 取消底部导航条安全区
 */
-(void)disableSafeAreaBottomInsets;


@end

NS_ASSUME_NONNULL_END
