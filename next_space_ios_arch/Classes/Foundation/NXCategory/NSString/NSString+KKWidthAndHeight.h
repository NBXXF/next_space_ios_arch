//
//  NSString+KKWidthAndHeight.h
//  kekeEngIad
//
//  Created by 关旭航 on 16/5/16.
//  Copyright © 2021年 可可. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (KKWidthAndHeight)

/**
 计算字体的size

 @param width 最大宽度
 @param font 字体
 @return size
 */
- (CGSize)getSizeWithWidth:(CGFloat)width font:(UIFont *)font;

/**
 计算字体高度

 @param width 最大宽度
 @param font 字体
 @return 高度
 */
- (CGFloat)getHeightWithWidth:(CGFloat)width font:(UIFont *)font;

/**
 计算字体宽度
 @param font 字号
 @return 宽度
 */
- (CGFloat)getWidthWithFont:(UIFont *)font;

/**
 计算特殊属性字体
 @param width 最大宽度
 @param font 字体
 @param paragraphStyle 属性
 @return 高度
 */
- (CGFloat)getHeightWithWidth:(CGFloat)width font:(UIFont*)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle;

/**
 计算特殊属性字体
 @param width 最大宽度
 @param font 字体
 @return 宽度
 */
- (CGFloat)getWidthWithWidth:(CGFloat)width font:(UIFont *)font;
@end
