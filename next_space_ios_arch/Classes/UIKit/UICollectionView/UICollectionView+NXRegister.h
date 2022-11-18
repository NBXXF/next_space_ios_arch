//
//  UICollectionView+NXRegister.h
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(NXRegister)
/**
 简化注册identifier 就是class名称
 */
- (void)registerClassforCellReuse:(nullable Class)cellClass;

/**
 简化注册identifier 就是class名称
 UICollectionElementKindSectionHeader
 UICollectionElementKindSectionFooter
 */
- (void)registerClassForSupplementaryView:(nullable Class)aClass kind:(NSString *)kind;


/**
 不注册也可以用,本质identifier 就是class名称
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithClass:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;


/**
 不注册也可以用,本质identifier 就是class名称
 */
- (nullable __kindof UICollectionReusableView *)dequeueReusableSupplementaryViewWithClass:(Class)aClass kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
