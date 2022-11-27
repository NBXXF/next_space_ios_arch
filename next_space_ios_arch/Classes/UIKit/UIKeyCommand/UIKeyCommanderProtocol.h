//
//  UIKeyCommander.h
//  Pods
//  事件分发协议
//  Created by XXF on 2022/10/21.
//

NS_ASSUME_NONNULL_BEGIN

@protocol UIKeyCommanderProtocol <NSObject>

/**
 递归式分发键盘快捷键事件 业务请复写,返回YES 将响应链自动断掉
 @param command 事件原始类
 @param event 业务唯一标识
 @param originatingResponder 响应事件的最原始Responder
 */
-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event originatingResponder:(UIResponder *)originatingResponder;

@end

NS_ASSUME_NONNULL_END
