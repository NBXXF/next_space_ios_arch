//
//  UICollectionView+NXAdaptation.h
//  next_space_ios_arch
// 适配
//  Created by XXF on 2023/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(NXAdaptation)

/**
 适配之后返回实际的格子宽度
 @param expectColumnWidth 期望的格子宽度
 @param columnRange 格子区间 最高优先级
 */
-(CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth columnRange:(NSRange)columnRange;


/**
 对应的分组 考虑分组可以设置内边距
 适配之后返回实际的格子宽度
 @param expectColumnWidth 期望的格子宽度
 @param columnRange 格子区间 最高优先级
 */
-(CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth
                  columnRange:(NSRange)columnRange
               sectionAtIndex:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
