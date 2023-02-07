//
//  NXSelectableObject.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/7.
//

#import "NXSelectableObject.h"
#import "NSArray+AppArch.h"
@interface NXSelectableObject()
/**
 是否选中
 */
@property(nonatomic,assign) BOOL isSelected;

/**
 是否无效,不可点击
 */
@property(nonatomic,assign) BOOL isDisable;

@end
@implementation NXSelectableObject

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
