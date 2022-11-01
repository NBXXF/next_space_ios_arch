//
//  NXItemMenuImpl.h
//  Pods
// 常见菜单模型封装 实现协议NXItemMenu
//  Created by XXF on 2022/10/29.
//

#import <Foundation/Foundation.h>
#import "NXItemMenu.h"
NS_ASSUME_NONNULL_BEGIN

@interface NXItemMenuImpl : NSObject<NXItemMenu>

- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon;

- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon andSelected:(BOOL)selected andDisable:(BOOL)disable andItem:(id __nullable)item;

@end

NS_ASSUME_NONNULL_END
