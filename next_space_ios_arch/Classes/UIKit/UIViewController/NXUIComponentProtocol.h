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
-(void)setComponentSize:(CGSize)size gravity:(NXComponentGravity)gravity;


/**
 设置组件透明度
 */
-(void)setComponentAlpha:(CGFloat)alpha;

/**
 设置组件背景色
 */
-(void)setComponentBackgroundColor:(UIColor *)color;

/**
 设置圆角
 */
-(void)setComponentCornerRadius:(CGFloat)radius;

/**
 设置阴影透明度
 */
-(void)setComponentShadowOpacity:(CGFloat)opacity;

/**
 点击外部是否可以取消
 */
-(void)setCanceledOnTouchOutside:(BOOL)cancel;


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
