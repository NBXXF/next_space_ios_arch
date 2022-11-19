//
//  NXItemMenuImpl.m
//  Pods
// 常见菜单模型封装 实现协议NXItemMenu
//  Created by XXF on 2022/10/29.
//

#import "NXItemMenuImpl.h"
#import "NSArray+AppArch.h"
@interface NXItemMenuImpl()
/**
 是否选中
 */
@property(nonatomic,assign) BOOL isSelected;

/**
 是否无效,不可点击
 */
@property(nonatomic,assign) BOOL isDisable;

@end
@implementation NXItemMenuImpl

+ (NSArray<id<NXSelectableProtocol>> *)getSelected:(NSArray<id<NXSelectableProtocol>> *)list{
    return [list filterObjectWithBlock:^BOOL(id<NXSelectableProtocol>  _Nonnull obj) {
        return [obj isItemSelected]&&![obj isItemDisable];
    }];
}

+ (id<NXSelectableProtocol>)getFirstSelected:(NSArray<id<NXSelectableProtocol>> *)list{
    return [list firstObjectWithBlock:^BOOL(id<NXSelectableProtocol>  _Nonnull obj) {
        return [obj isItemSelected]&&![obj isItemDisable];
    }];
}

+ (void)clearSelected:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setItemSelected:NO];
    }];
}

+ (void)selectAll:(NSArray<id<NXSelectableProtocol>> *)list{
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(![obj isItemDisable]){
            [obj setItemSelected:YES];
        }
    }];
}

+ (void)selectItem:(id<NXSelectableProtocol>)item inArray:(NSArray<id<NXSelectableProtocol>> *)list{
    if([item isItemDisable]){
        return;
    }
    [list enumerateObjectsUsingBlock:^(id<NXSelectableProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setItemSelected:item==obj];
    }];
    [item setItemSelected:YES];
}

@synthesize title;
@synthesize subTitle;
@synthesize icon;
@synthesize item;
@synthesize flag;
@synthesize tag;


- (instancetype)initWithBlock:(void (^)(__kindof NXItemMenuImpl * _Nonnull))block{
    self=[super init];
    if(self){
        block(self);
    }
    return self;
}

- (instancetype)initWithTitle: (NSString *)title andIcon:(NSString * __nullable)icon{
    return [self initWithTitle:title andIcon:icon andItem:nil andFlag:0 andTag:nil];
}
- (instancetype)initWithTitle:(NSString *)title andIcon:(NSString *)icon andItem:(id)item{
    return [self initWithTitle:title andIcon:icon andItem:item andFlag:0 andTag:nil];
}

- (instancetype)initWithTitle:(NSString *)title andIcon:(NSString *)icon andItem:(id)item andFlag:(NSInteger)flag{
    return [self initWithTitle:title andIcon:icon andItem:item andFlag:flag andTag:nil];
}

- (instancetype)initWithTitle:(NSString *)title andIcon:(NSString *)icon andItem:(id)item andFlag:(NSInteger)flag andTag:(id)tag{
    self=[super init];
    if(self){
        self.title=title;
        self.icon=icon;
        self.item=item;
        self.flag=flag;
        self.tag=tag;
    }
    return self;
}

- (void)setItemSelected:(BOOL)selected{
    _isSelected=selected;
}

- (BOOL)isItemSelected{
    return _isSelected;
}

- (BOOL)isItemDisable {
    return _isDisable;
}


- (void)setItemDisable:(BOOL)disable {
    _isDisable=disable;
}


@end
