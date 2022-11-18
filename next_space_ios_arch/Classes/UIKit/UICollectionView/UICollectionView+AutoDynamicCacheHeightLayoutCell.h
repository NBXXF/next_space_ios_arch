//
//  UICollectionView+AutoDynamicCacheHeightLayoutCell.h
//  next_space_ios_arch
//  cell自适应框架
//  Created by XXF on 2022/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(AutoDynamicCacheHeightLayoutCell)

/**
 *  caculate cell size
 *
 *  @param identifier    cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */
- (CGSize)autoSizeForCellWithIdentifier:(NSString *)identifier
                             indexPath:(NSIndexPath *)indexPath
                         configuration:
(void (^)(__kindof UICollectionViewCell *))
configuration;

/**
 *  caculate cell size with a fixed width
 *
 *  @param identifier    cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param fixedWidth    your expect width
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */

- (CGSize)autoSizeForCellWithIdentifier:(NSString *)identifier
                             indexPath:(NSIndexPath *)indexPath
                            fixedWidth:(CGFloat)fixedWidth
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration;

/**
 *  caculate cell size with fixed height
 *
 *  @param identifier    cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param fixedHeight    your expect height
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */

- (CGSize)autoSizeForCellWithIdentifier:(NSString *)identifier
                             indexPath:(NSIndexPath *)indexPath
                           fixedHeight:(CGFloat)fixedHeight
                         configuration:
(void (^)(__kindof UICollectionViewCell *cell))
configuration;


/**
 *  caculate cell size with fixed height
 *
 *  @param identifier    cell's reuse identifier
 *  @param indexPath     indexPath
 *  @param fixedWidth    your expect height
 *  @param configuration fill cell with you feed data
 *
 *  @return the caculated cell's height
 */

- (CGSize)autoSizeForReusableViewHeightIdentifier:(NSString *)identifier
                                             kind:(NSString *)kind
                                       indexPath:(NSIndexPath *)indexPath
                                      fixedWidth:(CGFloat)fixedWidth
                                   configuration:
(void (^)(__kindof UICollectionReusableView *cell))
configuration;
@end

NS_ASSUME_NONNULL_END

