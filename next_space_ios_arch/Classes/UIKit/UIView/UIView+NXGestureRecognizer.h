//
//  UIView+NXGestureRecognizer.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(NXGestureRecognizer)<UIGestureRecognizerDelegate>

/**
 uiview event回调
 */
typedef void (^NXViewTappedBlock)(void);

- (void)whenTapped:(NXViewTappedBlock)block;            //单击
- (void)whenDoubleTapped:(NXViewTappedBlock)block;      //双击
- (void)whenDoubleFingerTapped:(NXViewTappedBlock)block;//两根手指点击
- (void)whenLongPress:(NXViewTappedBlock)block;         //长按
- (void)whenTouchDown:(NXViewTappedBlock)block;         //开始点击时
- (void)whenTouchUp:(NXViewTappedBlock)block;           //结束点击时

@end

NS_ASSUME_NONNULL_END
