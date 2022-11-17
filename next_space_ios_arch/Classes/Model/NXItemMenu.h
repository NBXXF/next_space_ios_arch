//
//  ItemMenu.h
//  Pods
//  常见菜单模型封装
//  Created by XXF on 2022/10/29.
//
#import "NXSelectableProtocol.h"

@protocol NXItemMenu <NSObject,NXSelectableProtocol>

/**
 标题
 */
@required
@property(nonatomic,copy) NSString * _Nullable title;

/**
 icon
 */
@required
@property(nonatomic,copy) id _Nullable icon;

/**
 是否选中
 */
@required
@property(nonatomic,assign) BOOL isSelected;

/**
 是否无效,不可点击
 */
@required
@property(nonatomic,assign) BOOL isDisable;


/**
 一般为原始数据
 */
@optional
@property(nonatomic,copy) id __nullable item;

/**
 扩展标记字段
 */
@optional
@property(nonatomic,assign) NSInteger flag;


/**
 扩展tag字段
 */
@optional
@property(nonatomic,copy) id __nullable tag;

@end
