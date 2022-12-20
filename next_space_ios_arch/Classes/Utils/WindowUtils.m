//
//  WindowUtils.m
//  AppArch
//
//  Created by XXF on 2022/8/25.
//

#import "WindowUtils.h"

@implementation WindowUtils
///获取最顶层Window
+ (UIWindow *)topWindow {
    UIWindow * window;
    for (UIWindow * value in [[UIApplication sharedApplication].windows reverseObjectEnumerator]) {
        if (value.windowLevel == UIWindowLevelNormal) {
            window = value;
            break;
        }
    }
    return window ?: [[UIWindow alloc] init];
}
@end
