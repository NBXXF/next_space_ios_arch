//
//  UIView+NXVisibility.h
//  XXF
//  替代系统的hidden字段隐藏还展位的情况
//  Created by xxf on 2022/11/21.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewVisibility) {
    UIViewVisibilityVisible,//可见hidden==NO
    UIViewVisibilityInvisible,//等同于hidden==YES
    UIViewVisibilityGone//hidden==YES 且消除外边距 高度 宽度等
};

typedef NS_OPTIONS(NSUInteger, UIViewMarginDirection) {
    UIViewMarginDirectionNone       = 0,
    UIViewMarginDirectionTop        = 1 << 0,
    UIViewMarginDirectionLeft       = 1 << 1,
    UIViewMarginDirectionBottom     = 1 << 2,
    UIViewMarginDirectionRight      = 1 << 3,
    UIViewMarginDirectionAll        = UIViewMarginDirectionTop|UIViewMarginDirectionLeft|UIViewMarginDirectionBottom|UIViewMarginDirectionRight
};

@interface UIView(NXVisibility)

/**
 设置可见 默认隐藏margin
 */
-(void)setVisibility:(UIViewVisibility)visibility;

/**
 @param visibility 可见性
 @param affectedMarginDirections 相对隐藏margin,具体用法咨询XXF
 */
-(void)setVisibility:(UIViewVisibility)visibility affectedMarginDirections:(UIViewMarginDirection)affectedMarginDirections;

/**
 是否可见 取代 等同于hidden==NO
 */
-(BOOL)isVisible;

@end
