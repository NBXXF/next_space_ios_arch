//
//  UIApplication+NXTools.m
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/18.
//

#import "UIApplication+NXTools.h"

@implementation UIApplication(NXTools)

- (CGFloat)topLayoutOffset {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    } else {
        return [UIApplication sharedApplication].keyWindow.rootViewController.topLayoutGuide.length;
    }
    
}

- (CGFloat)bottomLayoutOffset {
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    } else {
        return [UIApplication sharedApplication].keyWindow.rootViewController.bottomLayoutGuide.length;
    }
}

@end
