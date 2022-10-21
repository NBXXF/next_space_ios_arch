//
//  UIResponder+DispatchKeyCommand.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder(DispatchKeyCommand)
/**
   递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
 -(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSNumber *)event{
     NSLog(@"===========>执行key %@ by %@  %@",command.input,self,event);
     return YES;
 }
 */
-(void)onDispatchKeyCommand:(UIKeyCommand *)command;
@end

NS_ASSUME_NONNULL_END
