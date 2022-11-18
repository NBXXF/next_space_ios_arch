//
//  UICollectionView+AutoDynamicCacheHeightLayoutCellByClass.m
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/18.
//

#import "UICollectionView+AutoDynamicCacheHeightLayoutCellByClass.h"
#import "UICollectionView+AutoDynamicCacheHeightLayoutCell.h"

@implementation UICollectionView(AutoDynamicCacheHeightLayoutCellByClass)

- (CGSize)autoSizeForCellWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                         configuration:
(void (^)(__kindof UICollectionViewCell *))
configuration{
    return [self autoSizeForCellWithIdentifier:NSStringFromClass(aClass) indexPath:indexPath configuration:configuration];
}


- (CGSize)autoSizeForCellWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                            fixedWidth:(CGFloat)fixedWidth
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration{
    return [self autoSizeForCellWithIdentifier:NSStringFromClass(aClass) indexPath:indexPath fixedWidth:fixedWidth configuration:configuration];
}


- (CGSize)autoSizeForCellWithWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                           fixedHeight:(CGFloat)fixedHeight
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration{
    return [self autoSizeForCellWithIdentifier:NSStringFromClass(aClass) indexPath:indexPath fixedHeight:fixedHeight configuration:configuration];
}



- (CGSize)autoSizeForReusableViewHeightWithClass:(Class)aClass
                                       indexPath:(NSIndexPath *)indexPath
                                      fixedWidth:(CGFloat)fixedWidth
                                   configuration:
(void (^)(__kindof UICollectionReusableView *cell))
configuration{
    return [self autoSizeForReusableViewHeightIdentifier:NSStringFromClass(aClass) indexPath:indexPath fixedWidth:fixedWidth configuration:configuration];
}
@end
