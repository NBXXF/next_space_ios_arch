//
//  UIKeyCommand+Responsible.h
//  由于ios 快捷键只响应第一响应者 在常见业务中需要分发,搭建一套分发拦截规则
//
//  Created by XXF on 2022/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIKeyCommand(Responsible)
/// Initializes a key command.
///  包装可分发的快捷键
/// @param title Short display title. This should be localized.
/// @param image Image that can appear next to this command, if needed.
/// @param input Keys that must be pressed to choose this command.
/// @param modifierFlags Bit mask of key modifier flags to choose this command.
/// @param event 业务唯一标识,更加清晰
/// @return A new key command.
+ (instancetype)dispatchCommandWithTitle:(NSString *)title
                           image:(nullable UIImage *)image
                           input:(NSString *)input
                   modifierFlags:(UIKeyModifierFlags)modifierFlags
                            commandEvent:(NSInteger) event;

/// Initializes a key command with alternates.
///  包装可分发的快捷键
/// @param title Short display title. This should be localized.
/// @param image Image that can appear next to this command, if needed.
/// @param input Keys that must be pressed to choose this command.
/// @param modifierFlags Bit mask of key modifier flags to choose this command.
/// @param alternates Alternates that differ in modifier flags.
/// @param event 业务唯一标识,更加清晰
/// @return A new key command.
+ (instancetype)dispatchCommandWithTitle:(NSString *)title
                           image:(nullable UIImage *)image
                           input:(NSString *)input
                   modifierFlags:(UIKeyModifierFlags)modifierFlags
                      alternates:(NSArray<UICommandAlternate *> *)alternates
                            commandEvent:(NSInteger) event API_AVAILABLE(ios(13.0));




// Creates an key command that will _not_ be discoverable in the UI.
// 包装可分发的快捷键
// @param event 业务唯一标识,更加清晰
+ (instancetype)dispatchKeyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags                        commandEvent:(NSInteger) event;


@end

NS_ASSUME_NONNULL_END
