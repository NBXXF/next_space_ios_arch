//
//  NXItemMenuImpl.m
//  Pods
// 常见菜单模型封装 实现协议NXItemMenu
//  Created by XXF on 2022/10/29.
//

#import "NXItemMenuImpl.h"

@implementation NXItemMenuImpl
+ (void)clearAllSelected:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:NO];
    }];
}

+ (void)selectAll:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:YES];
    }];
}

+ (void)selectItem:(id<NXSelectableProtocol>)item inArray:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:item==obj];
    }];
    [item setSelected:YES];
}

@synthesize title;
@synthesize icon;
@synthesize isSelected;
@synthesize isDisable;
@synthesize item;
@synthesize flag;
@synthesize tag;

- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon{
    self=[super init];
    if(self){
        self.title=title;
        self.icon=icon;
        self.isSelected=NO;
        self.isDisable=NO;
        self.item=nil;
        self.flag=0;
        self.tag=nil;
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
        self.flag=0;
        self.tag=nil;
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    isSelected=selected;
}

@end
