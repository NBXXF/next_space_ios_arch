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
 设置圆角
 */
-(void)setComponentCornerRadius:(CGFloat)radius;


/**
 设置组件背景色
 */
-(void)setComponentBackgroundColor:(UIColor *)color;


/**
 点击外部是否可以取消
 */
-(void)setCanceledOnTouchOutside:(BOOL)cancel;


@end

NS_ASSUME_NONNULL_END
