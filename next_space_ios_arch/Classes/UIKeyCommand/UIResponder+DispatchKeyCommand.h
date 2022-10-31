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
 逻辑规则 哪个类UIResponder 注册- (NSArray<UIKeyCommand *> *)keyCommands 那么就响应给谁
 然后框架封装了向上转发,用于业务不方便找寻上下文参数等
 
 关于冲突:如果UITextView 和ViewController 注册相同事件 那么UITextView 先响应 等价与系统firstResponder的概念
 
 
   递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
     业务请实现UIKeyCommanderProtocol 协议
 */
-(void)onDispatchKeyCommand:(UIKeyCommand *)command;
@end

NS_ASSUME_NONNULL_END
