//
//  UIView+Visibility.h
//  XXF
//  替代系统的hidden字段隐藏还展位的情况
//  Created by xxf on 2022/11/21.
//
#import <UIKit/UIKit.h>

@interface NSLayoutConstraint(Visibiltiy)

-(void)clear;
-(void)restore;

@end
