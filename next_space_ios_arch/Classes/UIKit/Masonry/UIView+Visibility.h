//
//  UIView+Visibility.h
//  XXF
//  替代系统的hidden字段隐藏还展位的情况
//  Created by xxf on 2022/11/21.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewVisibility) {
    UIViewVisibilityVisible,
    UIViewVisibilityInvisible,
    UIViewVisibilityGone
};

typedef NS_OPTIONS(NSUInteger, UIViewMarginDirection) {
    UIViewMarginDirectionNone       = 0,
    UIViewMarginDirectionTop        = 1 << 0,
    UIViewMarginDirectionLeft       = 1 << 1,
    UIViewMarginDirectionBottom     = 1 << 2,
    UIViewMarginDirectionRight      = 1 << 3,
    UIViewMarginDirectionAll        = UIViewMarginDirectionTop|UIViewMarginDirectionLeft|UIViewMarginDirectionBottom|UIViewMarginDirectionRight
};

@interface UIView(Visibility)

-(void)setVisibility:(UIViewVisibility)visibility;

-(void)setVisibility:(UIViewVisibility)visibility affectedMarginDirections:(UIViewMarginDirection)affectedMarginDirections;

-(BOOL)isVisible;

@end
