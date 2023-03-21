//
//  UIView+NXKeyboardSwitchControl.m
//  next_space_ios_arch
//  上下滑动自动关闭键盘
//  Created by XXF on 2023/3/20.
//

#import "UIView+NXKeyboardSwitchControl.h"
#import <next_space_ios_arch/NXKeyboardGestureRecognizer.h>
#import <next_space_ios_arch/NSArray+AppArch.h>
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation UIView(NXKeyboardSwitchControl)

- (BOOL)allowGestureRecognizeForKeyboard{
    return [self.gestureRecognizers containsObjectWithBlock:^BOOL(__kindof UIGestureRecognizer * _Nonnull value) {
        BOOL tag=[[value.objcAssociatedTag objectForKey:NSStringFromSelector(@selector(allowGestureRecognizeForKeyboard))] boolValue];
        return tag;
    }];
}
- (void)setAllowGestureRecognizeForKeyboard:(BOOL)isManageKeyboardSwitch{
    NSArray<NXKeyboardGestureRecognizer *> *recognizerArray =[self.gestureRecognizers filterObjectWithBlock:^BOOL(__kindof UIGestureRecognizer * _Nonnull value) {
        BOOL tag=[[value.objcAssociatedTag objectForKey:NSStringFromSelector(@selector(allowGestureRecognizeForKeyboard))] boolValue];
        return tag;
    }];

    //先移除
    [recognizerArray enumerateObjectsUsingBlock:^(NXKeyboardGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeGestureRecognizer:obj];
    }];
 
    if(isManageKeyboardSwitch){
        [self addGestureRecognizer:[[[NXKeyboardGestureRecognizer alloc] initWithTarget:self action:@selector(__swipeToDissmissKeyboard:)] applyWithBlock:^(NXKeyboardGestureRecognizer  *_Nonnull it) {
            it.direction=UISwipeGestureRecognizerDirectionUp;
            it.delegate=it;
            [it.objcAssociatedTag setObject:@YES forKey:NSStringFromSelector(@selector(allowGestureRecognizeForKeyboard))];
        }]];
        
        [self addGestureRecognizer:[[[NXKeyboardGestureRecognizer alloc] initWithTarget:self action:@selector(__swipeToDissmissKeyboard:)] applyWithBlock:^(NXKeyboardGestureRecognizer  *_Nonnull it) {
            it.direction=UISwipeGestureRecognizerDirectionDown;
            it.delegate=it;
            [it.objcAssociatedTag setObject:@YES forKey:NSStringFromSelector(@selector(allowGestureRecognizeForKeyboard))];
        }]];
    }
}

- (void)__swipeToDissmissKeyboard:(UISwipeGestureRecognizer *)swipe {
    //不能使用UIWindow 小组件没有这个设计,也不能是vc 如果直接添加到window上的就不行,所以找到最顶层的view
    UIView *superView=self.superview;
    while (superView) {
        UIView *next=superView.superview;
        if(next){
            superView=next;
        }else{
            break;
        }
    }
    [superView endEditing:YES];
    //一个父容器都没有的情况
    [self endEditing:YES];
}


@end
