//
//  UIResponder+DispatchKeyCommand.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/20.
//

#import "UIResponder+DispatchKeyCommand.h"
#import "UIKeyCommandConstant.h"
#import "NSObject+ExchangeMethod.h"
#import "NSObject+RateLimiting.h"

@implementation UIResponder(DispatchKeyCommand)
+ (void)load{
    //拦截系统本身的快捷键,系统本身的快捷键不会走正常流程
    
    /**
     -(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
         if (action == @selector(nx_undo) || action == @selector(nx_redo)) {
             return YES;
         }
         return [super canPerformAction:action withSender:sender];
     }

     -(void)validateCommand:(UICommand *)command {
         if (command.action == @selector(nx_undo)) {
             [self nx_undo];
         } else if (command.action == @selector(nx_redo)) {
             [self nx_redo];
         }
     }
     */
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject exchangeInstanceMethodWithSelfClass:UIResponder.class
                                     originalSelector:@selector(canPerformAction:withSender:)                     swizzledSelector:@selector(_dispatchCanPerformAction:withSender:)];
        
        [NSObject exchangeInstanceMethodWithSelfClass:UIResponder.class
                                     originalSelector:@selector(validateCommand:)                     swizzledSelector:@selector(_dispatchValidateCommand:)];
        
    });
}
/**
 替换自己的方法
 */
-(BOOL)_dispatchCanPerformAction:(SEL)action withSender:(id)sender{
    if(action==@selector(onDispatchKeyCommand:)){
        return YES;
    }else{
        return [self _dispatchCanPerformAction:action withSender:sender];
    }
}

-(void)_dispatchValidateCommand:(UICommand *)command  API_AVAILABLE(ios(13.0)){
    if(command.action==@selector(onDispatchKeyCommand:)){
        if([command isKindOfClass:UIKeyCommand.class]){
            //YYTextView 等存在多次分发的情况
            [self throttle:@selector(onDispatchKeyCommand:) withObject:(UIKeyCommand *)command duration:1.0];
            return;
        }
        //系统包装了一层 用kvc 取一遍
        UIKeyCommand *uiKeyCommand=nil;
        @try {
            id realCommand= [command valueForKey:@"command"];
            if([realCommand isKindOfClass:UIKeyCommand.class]){
                uiKeyCommand=(UIKeyCommand *)realCommand;
            }
        } @catch (NSException *exception) {
        }
        if(uiKeyCommand){
            //YYTextView 等存在多次分发的情况
            [self throttle:@selector(onDispatchKeyCommand:) withObject:uiKeyCommand duration:1.0];
            return;
        }
    }
    [self _dispatchValidateCommand:command];
}


-(void)onDispatchKeyCommand:(UIKeyCommand *)command{
    if(![command isKindOfClass:UIKeyCommand.class]){
        return;
    }
    NSString *commandEvent=nil;
    if (@available(iOS 13.0, *)) {
        if([command.propertyList isKindOfClass:NSDictionary.class]){
            NSDictionary *dic=(NSDictionary *)command.propertyList;
            id forEvent=dic[UIKeyCommandKeyCommandEvent];
            if([forEvent isKindOfClass:NSString.class]){
                commandEvent=(NSString *)forEvent;
            }
        }
    } else {
        commandEvent=nil;
    }
    
    //递归式分发 直到响应为止
    UIResponder *nextResponder = self;
    while (nextResponder) {
        SEL method=NSSelectorFromString(@"onKeyCommand:commandEvent:");
        if([nextResponder respondsToSelector:method]){
            if([nextResponder performSelector:method withObject:command withObject:commandEvent]){
                break;
            }
        }
        nextResponder=[nextResponder nextResponder];
    }
}
@end
