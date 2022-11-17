//
//  NXItemMenuImpl.m
//  Pods
// 常见菜单模型封装 实现协议NXItemMenu
//  Created by XXF on 2022/10/29.
//

#import "NXItemMenuImpl.h"
#import "NSArray+AppArch.h"

@implementation NXItemMenuImpl

+ (NSArray<id<NXSelectableProtocol>> *)getSelected:(NSArray<id<NXSelectableProtocol>> *)list{
    return [list filterObjectWithBlock:^BOOL(id<NXSelectableProtocol>  _Nonnull obj) {
        return [obj isItemSelected];
    }];
}

+ (id<NXSelectableProtocol>)getFirstSelected:(NSArray<id<NXSelectableProtocol>> *)list{
    return [list firstObjectWithBlock:^BOOL(id<NXSelectableProtocol>  _Nonnull obj) {
        return [obj isItemSelected];
    }];
}

+ (void)clearSelected:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setItemSelected:NO];
    }];
}

+ (void)selectAll:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setItemSelected:YES];
    }];
}

+ (void)selectItem:(id<NXSelectableProtocol>)item inArray:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setItemSelected:item==obj];
    }];
    [item setItemSelected:YES];
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

- (void)setItemSelected:(BOOL)selected{
    isSelected=selected;
}

- (BOOL)isItemSelected{
    return isSelected;
}

@end
