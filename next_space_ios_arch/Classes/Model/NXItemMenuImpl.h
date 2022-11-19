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

//万能初始化方法
- (instancetype)initWithBlock: (void (^)(__kindof NXItemMenuImpl * _Nonnull it))block;


- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon;


- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon andItem:(id __nullable)item;


- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon andItem:(id __nullable)item andFlag:(NSInteger)flag;


- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon andItem:(id __nullable)item andFlag:(NSInteger)flag andTag:(id __nullable)tag;

@end

NS_ASSUME_NONNULL_END
