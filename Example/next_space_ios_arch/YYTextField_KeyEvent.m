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
    return @[
             [UIKeyCommand dispatchCommandWithTitle:@"全选" image:nil input:@"d" modifierFlags:UIKeyModifierCommand commandEvent:@"101"]];
}
@end
