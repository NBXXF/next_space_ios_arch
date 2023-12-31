//
//  UIView+Shake.m
//  UIView+Shake
//    增加系统反馈
// Created by XXF on 2023/3/25.

#import "UIView+Shake.h"
#import <next_space_ios_arch/UIView+Feedback.h>

@implementation UIView (Shake)

- (void)shake {
    [self shake:5 withDelta:5 speed:0.03];
}

- (void)shake:(int)times
    withDelta:(CGFloat)delta {
    [self shake:times withDelta:delta completion:nil];
}

- (void)shake:(int)times
    withDelta:(CGFloat)delta
   completion:(nullable void (^)(void))handler {
    [self shake:times withDelta:delta speed:0.03 completion:handler];
}

- (void)shake:(int)times
    withDelta:(CGFloat)delta
        speed:(NSTimeInterval)interval {
    [self shake:times withDelta:delta speed:interval completion:nil];
}

- (void)shake:(int)times
    withDelta:(CGFloat)delta
        speed:(NSTimeInterval)interval
   completion:(nullable void (^)(void))handler {
    [self shake:times withDelta:delta speed:interval shakeDirection:ShakeDirectionHorizontal completion:handler];
}

- (void)shake:(int)times
    withDelta:(CGFloat)delta
        speed:(NSTimeInterval)interval
shakeDirection:(ShakeDirection)shakeDirection {
    [self shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)shake:(int)times
    withDelta:(CGFloat)delta
        speed:(NSTimeInterval)interval
shakeDirection:(ShakeDirection)shakeDirection
   completion:(nullable void (^)(void))completion {
    [self _shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_shake:(int)times
     direction:(int)direction
  currentTimes:(int)current
     withDelta:(CGFloat)delta
         speed:(NSTimeInterval)interval
shakeDirection:(ShakeDirection)shakeDirection
    completion:(void (^)(void))completionHandler {
    __weak UIView *weakSelf = self;
    //增加触觉反馈
    [weakSelf prepareFeedback];
    [weakSelf performFeedback];
	[UIView animateWithDuration:interval animations:^{
        switch (shakeDirection) {
            case ShakeDirectionVertical:
                weakSelf.layer.affineTransform = CGAffineTransformMakeTranslation(0, delta * direction);
                break;
            case ShakeDirectionRotation:
                weakSelf.layer.affineTransform = CGAffineTransformMakeRotation(M_PI * delta / 1000.0f * direction);
                break;
            case ShakeDirectionHorizontal:
                weakSelf.layer.affineTransform = CGAffineTransformMakeTranslation(delta * direction, 0);
            default:
                break;
        }
	} completion:^(BOOL finished) {
		if(current >= times) {
			[UIView animateWithDuration:interval animations:^{
				weakSelf.layer.affineTransform = CGAffineTransformIdentity;
			} completion:^(BOOL finished){
				if (completionHandler != nil) {
					completionHandler();
				}
			}];
			return;
		}
		[weakSelf _shake:times
		   direction:direction * -1
		currentTimes:current + 1
		   withDelta:delta
			   speed:interval
	  shakeDirection:shakeDirection
          completion:completionHandler];
	}];
}

@end
