//
//  NXSelectableProtocal.h
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NXSelectableProtocol <NSObject>
/**
 清除选中
 */
+(void)clearAllSelected:(NSArray<id<NXSelectableProtocol>>
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
-(void)setSelected:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
