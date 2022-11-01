//
//  NSMutableAttributedString+AppArch.h
//  JLRoutes
//
//  Created by XXF on 2022/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString(AppArch)

/**
 水平垂直居中样式 常用于处理emoji 不居中
 */
-(NSMutableAttributedString *)applyCenterStyleWithFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
