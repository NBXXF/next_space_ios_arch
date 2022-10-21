//
//  UIKeyCommand+Responsible.h
//  由于ios 快捷键只响应第一响应者 在常见业务中需要分发,搭建一套分发拦截规则
//
//  Created by XXF on 2022/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIKeyCommand(Responsible)

/**
 UIResponder 子类只需要声明这个方法即可
 
 递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString*)event{
   NSLog(@"===========>执行key %@ by %@  %@",command.input,self,event);
   return YES;
}
 */

/// Initializes a key command.
///  包装可分发的快捷键
/// @param title Short display title. This should be localized.
/// @param image Image that can appear next to this command, if needed.
/// @param input Keys that must be pressed to choose this command.
/// @param modifierFlags Bit mask of key modifier flags to choose this command.
/// @param event 业务唯一标识,更加清晰,一般可以选择用title来标识,防止不设置title 那么这个字段就有价值,（不设置title 不会显示在系统面板之中,长按cmd 可以查看）
/// @return A new key command.
+ (instancetype)dispatchCommandWithTitle:(NSString *)title
                           image:(nullable UIImage *)image
                           input:(NSString *)input
                   modifierFlags:(UIKeyModifierFlags)modifierFlags
                            commandEvent:(NSString *) event;

/**
 UIResponder 子类只需要声明这个方法即可
 
 递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString*)event{
   NSLog(@"===========>执行key %@ by %@  %@",command.input,self,event);
   return YES;
}
 */

/// Initializes a key command with alternates.
///  包装可分发的快捷键
/// @param title Short display title. This should be localized.
/// @param image Image that can appear next to this command, if needed.
/// @param input Keys that must be pressed to choose this command.
/// @param modifierFlags Bit mask of key modifier flags to choose this command.
/// @param alternates Alternates that differ in modifier flags.
/// @param event 业务唯一标识,更加清晰,一般可以选择用title来标识,防止不设置title 那么这个字段就有价值,（不设置title 不会显示在系统面板之中,长按cmd 可以查看）
/// @return A new key command.
+ (instancetype)dispatchCommandWithTitle:(NSString *)title
                           image:(nullable UIImage *)image
                           input:(NSString *)input
                   modifierFlags:(UIKeyModifierFlags)modifierFlags
                      alternates:(NSArray<UICommandAlternate *> *)alternates
                            commandEvent:(NSString *) event API_AVAILABLE(ios(13.0));



/**
 UIResponder 子类只需要声明这个方法即可
 
 递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString*)event{
   NSLog(@"===========>执行key %@ by %@  %@",command.input,self,event);
   return YES;
}
 */

// Creates an key command that will _not_ be discoverable in the UI.
// 包装可分发的快捷键
// @param event 业务唯一标识,更加清晰,一般可以选择用title来标识,防止不设置title 那么这个字段就有价值,（不设置title 不会显示在系统面板之中,长按cmd 可以查看）
+ (instancetype)dispatchKeyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags                        commandEvent:(NSString *) event;


@end

NS_ASSUME_NONNULL_END
