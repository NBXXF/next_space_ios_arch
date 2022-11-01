//
//  NXItemMenuImpl.m
//  Pods
// 常见菜单模型封装 实现协议NXItemMenu
//  Created by XXF on 2022/10/29.
//

#import "NXItemMenuImpl.h"

@implementation NXItemMenuImpl


@synthesize title;
@synthesize icon;
@synthesize isSelected;
@synthesize isDisable;
@synthesize item;

- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon{
    self=[super init];
    if(self){
        self.title=title;
        self.icon=icon;
        self.isSelected=NO;
        self.isDisable=NO;
        self.item=nil;
    }
    return self;
}

- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon andSelected:(BOOL)selected andDisable:(BOOL)disable andItem:(id __nullable)item{
    self=[super init];
    if(self){
        self.title=title;
        self.icon=icon;
        self.isSelected=selected;
        self.isDisable=disable;
        self.item=item;
    }
    return self;
}

@end
