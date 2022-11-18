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
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isHorizontalCenter:selfRect target:targetRect];
}

- (BOOL)isHorizontalCenterForTarget:(UIView *)target distance:(CGFloat)distance{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isHorizontalCenter:selfRect target:targetRect distance:distance];
}

- (BOOL)isVerticalCenterForTarget:(UIView *)target{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isVerticalCenter:selfRect target:targetRect];
}

- (BOOL)isVerticalCenterForTarget:(UIView *)target distance:(CGFloat)distance{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isVerticalCenter:selfRect target:targetRect distance:distance];
}

- (BOOL)isLeftForTarget:(UIView *)target strict:(BOOL)strict{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isLeft:selfRect target:targetRect strict:strict];
}

- (BOOL)isLeftForTarget:(UIView *)target{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isLeft:selfRect target:targetRect strict:YES];
}

- (BOOL)isRightForTarget:(UIView *)target strict:(BOOL)strict{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isRight:selfRect target:targetRect strict:strict];
}

- (BOOL)isRightForTarget:(UIView *)target{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isRight:selfRect target:targetRect strict:YES];
}

- (BOOL)isUpForTarget:(UIView *)target strict:(BOOL)strict{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isUp:selfRect target:targetRect strict:strict];
}

- (BOOL)isUpForTarget:(UIView *)target{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isUp:selfRect target:targetRect strict:YES];
}

- (BOOL)isDownForTarget:(UIView *)target strict:(BOOL)strict{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isDown:selfRect target:targetRect strict:strict];
}

- (BOOL)isDownForTarget:(UIView *)target{
    CGRect selfRect=[self convertRectToWindow];
    CGRect targetRect=[target convertRectToWindow];
    return [NXRectUtils isDown:selfRect target:targetRect strict:YES];
}


@end
