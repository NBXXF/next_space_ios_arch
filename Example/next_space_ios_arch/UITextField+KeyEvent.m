//
//  NXUITextField+KeyEvent.m
//  next_space_ios_arch_Example
//
//  Created by XXF on 2022/10/20.
//  Copyright © 2022 Wenjinfu. All rights reserved.
//

#import "UITextField+KeyEvent.h"
#import <next_space_ios_arch/UIKeyCommand+Responsible.h>

@implementation UITextField(KeyEvent)

//-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event{
//    NSLog(@"===========>执行key %@ by %@  %@  event:%@",command.input,self,self.placeholder,event);
//    return YES;
//}

- (NSArray<UIKeyCommand *> *)keyCommands{
    NSLog(@"===============>快捷键注册了 text");
//    return @[ [UIKeyCommand commandWithTitle:@"全选" image:nil action:@selector(onKeyCommands) input:@"a" modifierFlags:UIKeyModifierCommand propertyList:Nil]];
    UIKeyCommand *command= [UIKeyCommand dispatchCommandWithTitle:@"全选" image:nil input:@"b" modifierFlags:UIKeyModifierCommand commandEvent:@"101"];
    return @[command];
}
@end
