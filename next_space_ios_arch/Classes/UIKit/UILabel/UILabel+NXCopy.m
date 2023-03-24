//
//  UILabel+NXCopy.m
//  AFNetworking
//  支持能复制的Label
//  Created by XXF on 2023/3/23.
//

#import "UILabel+NXCopy.h"
#import <next_space_ios_arch/NSObject+NXAssociation.h>
#import <next_space_ios_arch/NSArray+AppArch.h>

@implementation UILabel(NXCopy)

-(NSString *)__keyCopyTextLongPressGestureRecognizer{
    return @"CopyTextLongPressGestureRecognizer";
}


- (BOOL)enableCopyText{
    return [self.gestureRecognizers containsObjectWithBlock:^BOOL(__kindof UIGestureRecognizer * _Nonnull value) {
        return [[value nx_getAssociatedObject:self.__keyCopyTextLongPressGestureRecognizer] boolValue];
    }];
}
- (void)setEnableCopyText:(BOOL)enableCopyText{
    //移除监听
    [[self.gestureRecognizers filterObjectWithBlock:^BOOL(__kindof UIGestureRecognizer * _Nonnull value) {
        return [[value nx_getAssociatedObject:self.__keyCopyTextLongPressGestureRecognizer] boolValue];
    }] enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeGestureRecognizer:obj];
    }];
    
    //增加监听
    if(enableCopyText){
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *textCopyLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__longPressdActionForCopyText:)];
        textCopyLongPressGesture.minimumPressDuration = 0.25;
        [textCopyLongPressGesture nx_setAssociatedObject:@YES forKey:self.__keyCopyTextLongPressGestureRecognizer];
        [self addGestureRecognizer:textCopyLongPressGesture];
    }
}


// 使label能够成为响应事件
- (BOOL)canBecomeFirstResponder {
    return self.enableCopyText;
}

// 自定义方法时才显示对就选项菜单，即屏蔽系统选项菜单
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(__customCopy:)){
        return YES;
    }
    return NO;
}

- (void)__customCopy:(id)sender {
     UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
     pasteboard.string = self.text;
}

- (void)__longPressdActionForCopyText:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"拷贝" action:@selector(__customCopy:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        menuController.menuItems = [NSArray arrayWithObjects:copyItem, nil];
        [menuController showMenuFromView:self.superview rect:self.frame];
    }
}
@end
