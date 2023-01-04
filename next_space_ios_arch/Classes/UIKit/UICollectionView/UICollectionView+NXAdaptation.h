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
 返回实际应该的width
 */
-(CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth;


/**
 对应的分组 考虑分组可以设置内边距
 */
-(CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth insetForSectionAtIndex:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
