//
//  UICollectionView+NXHeader.h
//  next_space_ios_arch
//  增加header机制
//  Created by xxf on 2022/11/18.
//

#import <UIKit/UIKit.h>
#import "NXCollectionViewHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(NXHeader)
/**
 header 实现采用contentInset的方式
 */
@property(nonatomic,strong,readonly)NXCollectionViewHeaderView *collectionHeaderView;

- (void)setCollectionHeaderView:(NXCollectionViewHeaderView *)collectionHeaderView headerHeight:(CGFloat)headerHeight;
@end

NS_ASSUME_NONNULL_END
