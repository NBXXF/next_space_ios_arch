//
//  UICollectionView+AutoDynamicCacheHeightLayoutCellByClass.h
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(AutoDynamicCacheHeightLayoutCellByClass)
/**
 *  caculate cell size
 *
 *  @param aClass    cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */
- (CGSize)autoSizeForCellWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                         configuration:
(void (^)(__kindof UICollectionViewCell *))
configuration;

/**
 *  caculate cell size with a fixed width
 *
 *  @param aClass    cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param fixedWidth    your expect width
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */

- (CGSize)autoSizeForCellWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                            fixedWidth:(CGFloat)fixedWidth
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration;

/**
 *  caculate cell size with fixed height
 *
 *  @param aClass   cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param fixedHeight    your expect height
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */

- (CGSize)autoSizeForCellWithWithClass:(Class)aClass
                             indexPath:(NSIndexPath *)indexPath
                           fixedHeight:(CGFloat)fixedHeight
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration;


/**
 *  caculate cell size with fixed height
 *
 *  @param aClass    cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param fixedWidth    your expect height
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */

- (CGSize)autoSizeForReusableViewHeightWithClass:(Class)aClass
                                       indexPath:(NSIndexPath *)indexPath
                                      fixedWidth:(CGFloat)fixedWidth
                                   configuration:
(void (^)(__kindof UICollectionReusableView *cell))
configuration;
@end

NS_ASSUME_NONNULL_END
