//
//  NXSelectableProtocal.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NXSelectableProtocol <NSObject>

/**
 获取选中的
 */
+(NSArray<id<NXSelectableProtocol>> *)getSelected:(NSArray<id<NXSelectableProtocol>>
                                                        *)list;

/**
 获取第一个选中的
 */
+(id<NXSelectableProtocol>)getFirstSelected:(NSArray<id<NXSelectableProtocol>>
                                                        *)list;


/**
 清除选中
 */
+(void)clearSelected:(NSArray<id<NXSelectableProtocol>>
                  *)list;
/**
 全选
 */
+(void)selectAll:(NSArray<id<NXSelectableProtocol>>
                  *)list;

/**
 单选
 */
+(void)selectItem:(id<NXSelectableProtocol>)item inArray:(NSArray<id<NXSelectableProtocol>>
                  *)list;


/**
 设置选中
 */
-(void)setItemSelected:(BOOL)selected;

/**
 是否选中
 */
-(BOOL)isItemSelected;


/**
 是否禁用状态
 */
-(void)setItemDisable:(BOOL)disable;

/**
 是否禁用状态
 */
-(BOOL)isItemDisable;

@end

NS_ASSUME_NONNULL_END
