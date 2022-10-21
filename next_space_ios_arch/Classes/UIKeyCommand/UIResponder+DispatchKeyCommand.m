//
//  UIResponder+DispatchKeyCommand.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/20.
//

#import "UIResponder+DispatchKeyCommand.h"
#import "UIKeyCommandConstant.h"

@implementation UIResponder(DispatchKeyCommand)

-(void)onDispatchKeyCommand:(UIKeyCommand *)command{
    NSInteger commandEvent=-1;
    if (@available(iOS 13.0, *)) {
        if([command.propertyList isKindOfClass:NSDictionary.class]){
            NSDictionary *dic=(NSDictionary *)command.propertyList;
            commandEvent=[dic[UIKeyCommandKeyCommandEvent] integerValue];
        }
    } else {
        commandEvent=-1;
    }
    
    //递归式分发 直到响应为止
    UIResponder *nextResponder = self;
    while (nextResponder) {
        SEL method=NSSelectorFromString(@"onKeyCommand:commandEvent:");
        if([nextResponder respondsToSelector:method]){
            if([nextResponder performSelector:method withObject:command withObject:@(commandEvent)]){
                break;
            }
        }
        nextResponder=[nextResponder nextResponder];
    }
}
@end
