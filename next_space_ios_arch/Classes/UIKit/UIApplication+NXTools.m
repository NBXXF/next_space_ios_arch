//
//  UIApplication+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/18.
//

#import "UIApplication+NXTools.h"

@implementation UIApplication(NXTools)

- (NSString *)appDisplayName{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}


- (UIWindow *)topWindow {
    UIWindow * window;
    for (UIWindow * value in [[UIApplication sharedApplication].windows reverseObjectEnumerator]) {
        if (value.windowLevel == UIWindowLevelNormal) {
            window = value;
            break;
        }
    }
    return window ?: [[UIWindow alloc] init];
}


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
