//
//  UIComponentProtocol.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NXUIComponentProtocol <NSObject>

/**
 开启底部导航条安全区
 additionalSafeAreaInsets 没什么效果,据说带了导航控制器也不行,这里采用传统方式
 */
-(void)enableSafeAreaBottomInsets;

/**
 取消底部导航条安全区
 */
-(void)disableSafeAreaBottomInsets;


@end

NS_ASSUME_NONNULL_END
