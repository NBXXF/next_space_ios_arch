//
//  NXKeyboardControlView.m
//  AFNetworking
//  滑动自动关闭键盘
//  Created by XXF on 2023/3/20.
//

#import "NXKeyboardControlView.h"

@implementation NXKeyboardControlView

- (instancetype)init{
    self=[super init];
    if(self){
        [self _initKeyboardControl];
    }
    return self;
}

-(void)_initKeyboardControl{
    UISwipeGestureRecognizer* swipeDirection_down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(_swipeDirectionDownMethod:)];
    UISwipeGestureRecognizer* swipeDirection_up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(_swipeDirectionUpMethod:)];
    swipeDirection_down.direction = UISwipeGestureRecognizerDirectionDown;
    swipeDirection_up.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer: swipeDirection_down];
    [self addGestureRecognizer: swipeDirection_up];
}


- (void)_swipeDirectionDownMethod:(UISwipeGestureRecognizer *)swipe {
    [self endEditing:YES];
}

- (void)_swipeDirectionUpMethod:(UISwipeGestureRecognizer *)swipe {
    [self endEditing:YES];
}

@end
