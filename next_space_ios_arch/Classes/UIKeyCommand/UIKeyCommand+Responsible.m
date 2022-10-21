//
//  UIKeyCommand+Responsible.m
//  由于ios 快捷键只响应第一响应者 在常见业务中需要分发,搭建一套分发拦截规则
//  Created by XXF on 2022/10/20.
//

#import "UIKeyCommand+Responsible.h"
#import "UIKeyCommandConstant.h"

@implementation UIKeyCommand(Responsible)

+ (instancetype)dispatchCommandWithTitle:(NSString *)title image:(UIImage *)image input:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags  commandEvent:(NSString *) event{
    return [UIKeyCommand commandWithTitle:title image:image action: [self getDefaulActionSelector] input:input modifierFlags:modifierFlags propertyList:[NSDictionary dictionaryWithObject:event forKey:UIKeyCommandKeyCommandEvent]];
}


+ (instancetype)dispatchCommandWithTitle:(NSString *)title image:(UIImage *)image input:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags alternates:(NSArray<UICommandAlternate *> *)alternates     commandEvent:(NSString *) event API_AVAILABLE(ios(13.0)){
    return [UIKeyCommand commandWithTitle:title image:image action: [self getDefaulActionSelector] input:input modifierFlags:modifierFlags propertyList:[NSDictionary dictionaryWithObject:event forKey:UIKeyCommandKeyCommandEvent] alternates:alternates];
}

+ (instancetype)dispatchKeyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags commandEvent:(NSString *) event{
    return [UIKeyCommand commandWithTitle:@"" image:nil action: [self getDefaulActionSelector] input:input modifierFlags:modifierFlags propertyList:[NSDictionary dictionaryWithObject:event forKey:UIKeyCommandKeyCommandEvent]];
}

/**
 默认响应的事件分发
 */
+(SEL)getDefaulActionSelector{
    return NSSelectorFromString(@"onDispatchKeyCommand:");
}

@end
