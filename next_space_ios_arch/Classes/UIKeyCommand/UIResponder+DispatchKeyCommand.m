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
#import "UIKeyCommanderProtocol.h"
#import "RACScheduler+AppArch.h"

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
            [self onDispatchKeyCommand:(UIKeyCommand *)command];
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
            //永远取消上一次
            [self removeLastCallKeyCommandMethodTask];
            
            //YYText 长按cmd  会把所有快捷键执行一次,先用算法 如果150ms 超过2次 就判断为用户长按cmd了
            NSInteger lastCalled = [self getCallKeyCommandMethodCount];
            lastCalled=lastCalled+1;
            [self setCallKeyCommandMethodCount:lastCalled];
            if(lastCalled>2){
                //延迟恢复
                [RACScheduler afterDelayInMainThreadScheduler:0.5 schedule:^{
                    [self setCallKeyCommandMethodCount:0];
                }];
                return;
            }
   
            
            //添加延迟任务
            RACDisposable *task= [RACScheduler afterDelayInMainThreadScheduler:0.15 schedule:^{
                [self setCallKeyCommandMethodCount:0];
                [self onDispatchKeyCommand:uiKeyCommand];
            }];
            [self addCallKeyCommandMethodTask:task];
            return;
        }
    }
    [self _dispatchValidateCommand:command];
}

/**
 添加全局任务
 */
-(void)addCallKeyCommandMethodTask:(RACDisposable *)task{
    NSMutableDictionary *throttleData= UIApplication.sharedApplication.getThrottleData;
    NSString *key=[NSString stringWithFormat:@"%@_task",NSStringFromSelector(@selector(_dispatchValidateCommand:))];
    [throttleData setObject:task forKey:key];
}

/**
 移除上次任务
 */
-(void)removeLastCallKeyCommandMethodTask{
    NSMutableDictionary *throttleData= UIApplication.sharedApplication.getThrottleData;
    NSString *key=[NSString stringWithFormat:@"%@_task",NSStringFromSelector(@selector(_dispatchValidateCommand:))];
    RACDisposable *task= [throttleData objectForKey:key];
    if(task&&!task.isDisposed){
        [task dispose];
    }
    [throttleData removeObjectForKey:key];
}


/**
 统计执行次数
 */
-(NSInteger)getCallKeyCommandMethodCount{
    NSMutableDictionary *throttleData= UIApplication.sharedApplication.getThrottleData;
    NSString *key=NSStringFromSelector(@selector(_dispatchValidateCommand:));
    NSInteger lastCalled = [[throttleData objectForKey:key] integerValue];
    return lastCalled;
}

/**
 更新执行次数
 */
-(void)setCallKeyCommandMethodCount:(NSInteger)count{
    NSMutableDictionary *throttleData= UIApplication.sharedApplication.getThrottleData;
    NSString *key=NSStringFromSelector(@selector(_dispatchValidateCommand:));
    [throttleData setObject:@(count) forKey:key];
}



-(void)onDispatchKeyCommand:(UIKeyCommand *)command{
   // [self setCallMethodCount:0];
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
    UIResponder *originatingResponder=self;
    @try {
        //YYText 传递的是originatingResponder
        id responder= [command valueForKey:@"originatingResponder"];
        if([responder isKindOfClass:UIResponder.class]){
            originatingResponder=(UIResponder *)responder;
        }
    } @catch (NSException *exception) {
    }
    //增加阻塞 防暴力, //YYTextView 等存在多次分发的情况
    [originatingResponder throttleWithSelector:@selector(dispatchUIResponder:commandEvent:) withObject:command withObject:commandEvent duration:0.0];

}
-(void)dispatchUIResponder:(UIKeyCommand *)command commandEvent:(NSString *)commandEvent{
    if(commandEvent&&[NSObject isRateLimitingWithId:commandEvent duration:0.3]){
        //多个组件 同一个事件频率太高,YYText也有bug
        return;
    }
    //递归式分发 直到响应为止
    UIResponder *originatingResponder=self;
    UIResponder *nextResponder = self;
    while (nextResponder) {
        if([nextResponder conformsToProtocol:@protocol(UIKeyCommanderProtocol)]){
            id<UIKeyCommanderProtocol> ani = (id)nextResponder;
            if([ani onKeyCommand:command commandEvent:commandEvent originatingResponder:originatingResponder]){
                break;
            }
        }
        nextResponder=[nextResponder nextResponder];
    }
}
@end
