//
//  WindowUtils.h
//  AppArch
//  窗口管理工具类
//  Created by XXF on 2022/8/25.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
NS_ASSUME_NONNULL_BEGIN

@interface WindowUtils : NSObject
///获取最顶层Window
+ (UIWindow *)topWindow;
@end

NS_ASSUME_NONNULL_END
