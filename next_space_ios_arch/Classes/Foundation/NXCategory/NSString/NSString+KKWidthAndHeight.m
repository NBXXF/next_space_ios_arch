//
//  NSString+KKWidthAndHeight.m
//  kekeEngIad
//
//  Created by 关旭航 on 16/5/16.
//  Copyright © 2021年 可可. All rights reserved.
//

#import "NSString+KKWidthAndHeight.h"

@implementation NSString (KKWidthAndHeight)

- (CGFloat)getHeightWithWidth:(CGFloat)width font:(UIFont*)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName,nil];
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dict context:nil].size;
    return ceil(size.height);
}

- (CGSize)getSizeWithWidth:(CGFloat)width font:(UIFont *)font
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil];
    return rect.size;
}
- (CGFloat)getHeightWithWidth:(CGFloat)width font:(UIFont *)font
{
    return ceil([self getSizeWithWidth:width font:font].height) + 1;
}

- (CGFloat)getWidthWithFont:(UIFont *)font
{
    return ceil([self getSizeWithWidth:10000 font:font].width);
}

- (CGFloat)getWidthWithWidth:(CGFloat)width font:(UIFont *)font;
{
    return ceil([self getSizeWithWidth:width font:font].width);
}


@end
