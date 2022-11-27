//
//  NSMutableAttributedString+AppArch.m
//  JLRoutes
//
//  Created by XXF on 2022/11/1.
//

#import "NSMutableAttributedString+AppArch.h"

@implementation NSMutableAttributedString(AppArch)

- (NSMutableAttributedString *)applyCenterStyleWithFont:(UIFont *)font{
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc] initWithAttributedString:self];
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc] init];
    style.alignment=NSTextAlignmentCenter;
    CGFloat indent=floor((font.lineHeight-font.pointSize)/2);
    if(indent<0){
        indent=0;
    }else if(indent>(font.lineHeight/2)){
        indent=0;
    }
    style.firstLineHeadIndent=indent;
    [str addAttributes:@{NSParagraphStyleAttributeName:style,
                         NSFontAttributeName:font,
                       } range:NSMakeRange(0, str.length)];
    return str;
}

@end
