//
//  NXKeyboardGestureRecognizer.m
//  next_space_ios_arch
//  处理多个手势问题
//  Created by XXF on 2023/3/21.
//

#import "NXKeyboardGestureRecognizer.h"

@implementation NXKeyboardGestureRecognizer

/**
 支持多个手势同时在线
 */
- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UISwipeGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
