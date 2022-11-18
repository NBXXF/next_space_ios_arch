//
//  UICollectionView+NXRegister.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/18.
//

#import "UICollectionView+NXRegister.h"

@implementation UICollectionView(NXRegister)
/**
 简化注册identifier 就是class名称
 */
- (void)registerClassforCellReuse:(nullable Class)cellClass{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}


/**
 简化注册identifier 就是class名称
 UICollectionElementKindSectionHeader
 UICollectionElementKindSectionFooter
 */
- (void)registerClassForSupplementaryView:(nullable Class)aClass kind:(NSString *)kind {
    [self registerClass:aClass forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(aClass)];
}


/**
 不注册也可以用,本质identifier 就是class名称
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath{
    [self registerClassforCellReuse:cellClass];
    return [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}


/**
 不注册也可以用,本质identifier 就是class名称
 */
- (nullable __kindof UICollectionReusableView *)dequeueReusableSupplementaryViewWithClass:(Class)aClass kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath{
    [self registerClassForSupplementaryView:aClass kind:kind];
    return [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(aClass) forIndexPath:indexPath];
}

@end
