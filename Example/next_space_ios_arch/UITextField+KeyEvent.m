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

-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event{
    NSLog(@"===========>执行key %@ by %@  %@  event:%@",command.input,self,self.placeholder,event);
    return YES;
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

- (NSArray<UIKeyCommand *> *)keyCommands{
    NSLog(@"===============>快捷键注册了 text");
    return @[
        [UIKeyCommand commandWithTitle:@"撤销" image:nil action:@selector(nx_undo) input:@"z" modifierFlags:UIKeyModifierCommand propertyList:nil],
        [UIKeyCommand dispatchCommandWithTitle:@"全选" image:nil input:@"z" modifierFlags:UIKeyModifierCommand commandEvent:@"101"],
             [UIKeyCommand dispatchCommandWithTitle:@"全选" image:nil input:@"i" modifierFlags:UIKeyModifierCommand commandEvent:@"101"]];
}
@end
