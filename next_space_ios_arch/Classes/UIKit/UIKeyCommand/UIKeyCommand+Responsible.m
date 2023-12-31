//
//  UIKeyCommand+Responsible.m
//  由于ios 快捷键只响应第一响应者 在常见业务中需要分发,搭建一套分发拦截规则
//  Created by XXF on 2022/10/20.
//

#import "UIKeyCommand+Responsible.h"
#import "UIKeyCommandConstant.h"

/**
 逻辑规则 哪个类UIResponder 注册- (NSArray<UIKeyCommand *> *)keyCommands 那么就响应给谁
 然后框架封装了向上转发,用于业务不方便找寻上下文参数等
 */
@implementation UIKeyCommand(Responsible)

/**
 UIResponder 子类只需要声明这个方法即可
 
 递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
 业务请实现UIKeyCommanderProtocol 协议
 */
+ (instancetype)dispatchCommandWithTitle:(NSString *)title image:(UIImage *)image input:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags  commandEvent:(NSString *) event{
    return [UIKeyCommand commandWithTitle:title image:image action: [self getDefaulActionSelector] input:input modifierFlags:modifierFlags propertyList:[NSDictionary dictionaryWithObject:event forKey:UIKeyCommandKeyCommandEvent]];
}


+ (instancetype)dispatchCommandWithTitle:(NSString *)title image:(UIImage *)image input:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags commandEvent:(NSString *)event apply:(void (^)(UIKeyCommand * _Nonnull))apply{
    UIKeyCommand *com=[self dispatchCommandWithTitle:title image:image input:input modifierFlags:modifierFlags commandEvent:event];
    apply(com);
    return com;
}
/**
 UIResponder 子类只需要声明这个方法即可
 
 递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
 业务请实现UIKeyCommanderProtocol 协议
 */
+ (instancetype)dispatchCommandWithTitle:(NSString *)title image:(UIImage *)image input:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags alternates:(NSArray<UICommandAlternate *> *)alternates     commandEvent:(NSString *) event API_AVAILABLE(ios(13.0)){
    return [UIKeyCommand commandWithTitle:title image:image action: [self getDefaulActionSelector] input:input modifierFlags:modifierFlags propertyList:[NSDictionary dictionaryWithObject:event forKey:UIKeyCommandKeyCommandEvent] alternates:alternates];
}

/**
 UIResponder 子类只需要声明这个方法即可
 
 递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
 业务请实现UIKeyCommanderProtocol 协议
 */
+ (instancetype)dispatchKeyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags commandEvent:(NSString *) event{
    return [UIKeyCommand commandWithTitle:@"" image:nil action: [self getDefaulActionSelector] input:input modifierFlags:modifierFlags propertyList:[NSDictionary dictionaryWithObject:event forKey:UIKeyCommandKeyCommandEvent]];
}

/**
 默认响应的事件分发
 */
+(SEL)getDefaulActionSelector{
    return NSSelectorFromString(UIKeyCommandDefaultMethod);
}

+ (NSMutableArray<UIKeyCommand *> *)combineArray:(NSArray<UIKeyCommand *> *)first second:(NSArray<UIKeyCommand *> *)second{
    
    NSMutableArray<UIKeyCommand *> *results=[NSMutableArray arrayWithArray:first];
    [results addObjectsFromArray:second];
    return results;
}

+ (NSMutableArray<UIKeyCommand *> *)combineArray:(NSArray<UIKeyCommand *> *)first second:(NSArray<UIKeyCommand *> *)second third:(NSArray<UIKeyCommand *> *)third{
    
    NSMutableArray<UIKeyCommand *> *results=[NSMutableArray arrayWithArray:first];
    [results addObjectsFromArray:second];
    [results addObjectsFromArray:third];
    return results;
}
@end
