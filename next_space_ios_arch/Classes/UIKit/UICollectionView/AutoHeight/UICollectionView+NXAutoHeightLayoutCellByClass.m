//
//  UICollectionView+NXAutoHeightLayoutCellByClass.m
//  next_space_ios_arch
//   高度自适应框架
//  Created by 1234 on 2022/11/18.
//
/**
 
 不要设置（发现的坑1）
 //flowlayout.estimatedItemSize
 //flowlayout.itemSize；
 
 // 都应用我封装 的全部用class 方法的方法 不要直接用xxxxWithIdentifier方法,否则请先确保[cell layoutIfNeeded] 执行完所有布局约束
 
 
 
 在UICollectionView 代理方法中复写
 教程
 -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
 {
     return [collectionView autoSizeForCellWithClass:NXPayCouponCell.class
                                           indexPath:indexPath
                                          fixedWidth:collectionView.width
                                       configuration:^(id cell) {
         [cell mock];
     }];
 }
 */

#import "UICollectionView+NXAutoHeightLayoutCellByClass.h"
#import "UICollectionView+NXAutoHeightLayoutCell.h"
#import "UICollectionView+NXRegister.h"

@implementation UICollectionView(NXAutoHeightLayoutCellByClass)

- (CGSize)autoSizeForCellWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                         configuration:
(void (^)(__kindof UICollectionViewCell *))
configuration{
    UIView *cell=[self dequeueReusableCellWithClass:aClass forIndexPath:indexPath];
    [cell layoutIfNeeded];
    return [self autoSizeForCellWithIdentifier:NSStringFromClass(aClass) indexPath:indexPath configuration:configuration];
}


- (CGSize)autoSizeForCellWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                            fixedWidth:(CGFloat)fixedWidth
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration{
    UIView *cell=[self dequeueReusableCellWithClass:aClass forIndexPath:indexPath];
    [cell layoutIfNeeded];
    return [self autoSizeForCellWithIdentifier:NSStringFromClass(aClass) indexPath:indexPath fixedWidth:fixedWidth configuration:configuration];
}


- (CGSize)autoSizeForCellWithWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                           fixedHeight:(CGFloat)fixedHeight
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration{
    UIView *cell=[self dequeueReusableCellWithClass:aClass forIndexPath:indexPath];
    [cell layoutIfNeeded];
    return [self autoSizeForCellWithIdentifier:NSStringFromClass(aClass) indexPath:indexPath fixedHeight:fixedHeight configuration:configuration];
}



- (CGSize)autoSizeForReusableViewHeightWithClass:(Class)aClass
                                            kind:(NSString *)kind
                                       indexPath:(NSIndexPath *)indexPath
                                      fixedWidth:(CGFloat)fixedWidth
                                   configuration:
(void (^)(__kindof UICollectionReusableView *cell))
configuration{
    UIView *cell=[self dequeueReusableSupplementaryViewWithClass:aClass kind:kind indexPath:indexPath];
    [cell layoutIfNeeded];
    return [self autoSizeForReusableViewHeightIdentifier:NSStringFromClass(aClass)
                                                    kind:kind
                                               indexPath:indexPath fixedWidth:fixedWidth configuration:configuration];
}
@end