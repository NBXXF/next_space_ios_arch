//
//  UIView+AppArchRect.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import "UIView+AppArchRect.h"
#import "NXRectUtils.h"

@implementation UIView(AppArchRec)

- (CGPoint)convertPointToWindow{
    CGPoint selfPoint=[self.superview convertPoint:self.frame.origin toView:self.window];
    return selfPoint;
}

- (CGRect)convertRectToWindow{
    CGRect selfRect=[self.superview convertRect:self.frame toView:self.window];
    return selfRect;
}

- (BOOL)isHorizontalCenterForTarget:(UIView *)target{
    return [NXRectUtils isHorizontalCenter:self.frame target:target.frame];
}

- (BOOL)isHorizontalCenterForTarget:(UIView *)target distance:(CGFloat)distance{
    return [NXRectUtils isHorizontalCenter:self.frame target:target.frame distance:distance];
}

- (BOOL)isVerticalCenterForTarget:(UIView *)target{
    return [NXRectUtils isVerticalCenter:self.frame target:target.frame];
}

- (BOOL)isVerticalCenterForTarget:(UIView *)target distance:(CGFloat)distance{
    return [NXRectUtils isVerticalCenter:self.frame target:target.frame distance:distance];
}

- (BOOL)isLeftForTarget:(UIView *)target strict:(BOOL)strict{
    return [NXRectUtils isLeft:self.frame target:target.frame strict:strict];
}

- (BOOL)isLeftForTarget:(UIView *)target{
    return [NXRectUtils isLeft:self.frame target:target.frame strict:YES];
}

- (BOOL)isRightForTarget:(UIView *)target strict:(BOOL)strict{
    return [NXRectUtils isRight:self.frame target:target.frame strict:strict];
}

- (BOOL)isRightForTarget:(UIView *)target{
    return [NXRectUtils isRight:self.frame target:target.frame strict:YES];
}

- (BOOL)isUpForTarget:(UIView *)target strict:(BOOL)strict{
    return [NXRectUtils isUp:self.frame target:target.frame strict:strict];
}

- (BOOL)isUpForTarget:(UIView *)target{
    return [NXRectUtils isUp:self.frame target:target.frame strict:YES];
}

- (BOOL)isDownForTarget:(UIView *)target strict:(BOOL)strict{
    return [NXRectUtils isDown:self.frame target:target.frame strict:strict];
}

- (BOOL)isDownForTarget:(UIView *)target{
    return [NXRectUtils isDown:self.frame target:target.frame strict:YES];
}


@end
