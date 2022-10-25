//
//  YYTextField_KeyEvent.m
//  next_space_ios_arch_Example
//
//  Created by XXF on 2022/10/24.
//  Copyright © 2022 Wenjinfu. All rights reserved.
//

#import "YYTextField_KeyEvent.h"
#import <next_space_ios_arch/UIKeyCommand+Responsible.h>

@implementation YYTextView(KeyEvent)
-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event{
    NSLog(@"===========>执行key %@ by %@  %@  event:%@",command.input,self,@"",event);
    return YES;
}

- (NSArray<UIKeyCommand *> *)keyCommands{
    //ReturnOrEnter
//    return @[
//             [UIKeyCommand dispatchCommandWithTitle:@"换行" image:nil input:@"\r" modifierFlags:UIKeyModifierShift commandEvent:@"101"]];
//
    return @[
             [UIKeyCommand dispatchCommandWithTitle:@"换行" image:nil input:@"\r" modifierFlags:0 commandEvent:@"102"],
             [UIKeyCommand dispatchCommandWithTitle:@"cmd+回车" image:nil input:@"\r" modifierFlags:UIKeyModifierCommand commandEvent:@"103"],
             [UIKeyCommand dispatchCommandWithTitle:@"cmd+0" image:nil input:@"o" modifierFlags:UIKeyModifierCommand commandEvent:@"104"],];

//    return @[];
}
@end
