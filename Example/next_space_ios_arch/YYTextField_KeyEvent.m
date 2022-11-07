//
//  YYTextField_KeyEvent.m
//  next_space_ios_arch_Example
//
//  Created by XXF on 2022/10/24.
//  Copyright © 2022 Wenjinfu. All rights reserved.
//

#import "YYTextField_KeyEvent.h"
#import <next_space_ios_arch/UIKeyCommand+Responsible.h>
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>

@implementation YYTextView(KeyEvent)
- (BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event originatingResponder:(UIResponder *)originatingResponder{
    NSLog(@"===========>执行key %@ by %@  %@  event:%@ originatingResponder:%@",command.input,self.simpleDescription,@"",event,originatingResponder.simpleDescription);
//    if([event isEqual:UIKeyInputLeftArrow]){
//        UIView *findTextInput= [self.superview.superview findLastChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
//            return [childView isTextInputView]&&[childView isLeftForView:self];
//        } deepQuery:YES];
//        [findTextInput becomeFirstResponder];
//        return YES;
//    }else if([event isEqual:UIKeyInputRightArrow]){
//        UIView *findTextInput= [self.superview.superview findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
//            return [childView isTextInputView]&&[childView isRightForView:self];
//        } deepQuery:YES];
//        [findTextInput becomeFirstResponder];
//        return YES;
//    }else if([event isEqual:UIKeyInputUpArrow]){
//        UIView *findTextInput= [self.superview.superview findLastChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
//            BOOL result=[childView isTextInputView]&&[childView isUpForView:self];
//            return result;
//        } deepQuery:YES];
//        [findTextInput becomeFirstResponder];
//        return YES;
//    }else if([event isEqual:UIKeyInputDownArrow]){
//        UIView *findTextInput= [self.superview.superview findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
//            return [childView isDownForView:self]&&[childView isTextInputView];
//        } deepQuery:YES];
//        [findTextInput becomeFirstResponder];
//        return YES;
//    }
    return NO;
}
-(void)test{
    NSLog(@"===========>执行key lala");
}
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    return YES;
//}
//- (void)validateCommand:(UICommand *)command{
//    NSLog(@"===========>执行key222 %@ by %@  %@",command.title,self,self.placeholder);
//}

//- (NSArray<UIKeyCommand *> *)keyCommands{
//    NSLog(@"===============>快捷键注册了 text");
//    UIKeyCommand *key=  [UIKeyCommand dispatchKeyCommandWithInput:@"." modifierFlags:UIKeyModifierCommand commandEvent:UIKeyInputLeftArrow];
//    if (@available(iOS 15.0, *)) {
//        key.allowsAutomaticMirroring=NO;
//        key.wantsPriorityOverSystemBehavior=YES;
//        key.allowsAutomaticLocalization=NO;
//    } else {
//        // Fallback on earlier versions
//    }
//    
//    return @[
//        key,
//        [UIKeyCommand dispatchKeyCommandWithInput:@"." modifierFlags:UIKeyModifierControl commandEvent:UIKeyInputLeftArrow],
//        [UIKeyCommand dispatchKeyCommandWithInput:UIKeyInputLeftArrow modifierFlags:0 commandEvent:UIKeyInputLeftArrow],
//        [UIKeyCommand dispatchKeyCommandWithInput:UIKeyInputRightArrow modifierFlags:0 commandEvent:UIKeyInputRightArrow],
//        [UIKeyCommand dispatchKeyCommandWithInput:UIKeyInputUpArrow modifierFlags:0 commandEvent:UIKeyInputUpArrow],
//        [UIKeyCommand dispatchKeyCommandWithInput:UIKeyInputDownArrow modifierFlags:0 commandEvent:UIKeyInputDownArrow],
//        [UIKeyCommand dispatchKeyCommandWithInput:@"O" modifierFlags:UIKeyModifierCommand commandEvent:UIKeyInputDownArrow]
//    ];
//}
@end
