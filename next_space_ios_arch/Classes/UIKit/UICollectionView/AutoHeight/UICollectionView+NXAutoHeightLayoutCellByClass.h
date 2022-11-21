////
////  UICollectionView+NXAutoHeightLayoutCellByClass.h
////  next_space_ios_arch
////   高度自适应框架
////  Created by xxf on 2022/11/18.
////
//
///**
// 
// 不要设置（发现的坑1）
// //flowlayout.estimatedItemSize
// //flowlayout.itemSize；
// 
// // 都应用我封装 的全部用class 方法的方法 不要直接用xxxxWithIdentifier方法,否则请先确保[cell layoutIfNeeded] 执行完所有布局约束
// 
// 
// 
// 在UICollectionView 代理方法中复写
// 教程
// -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
// {
//     return [collectionView autoSizeForCellWithClass:NXPayCouponCell.class
//                                           indexPath:indexPath
//                                          fixedWidth:collectionView.width
//                                       configuration:^(id cell) {
//         [cell mock];
//     }];
// }
// */
//#import <UIKit/UIKit.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface UICollectionView(NXAutoHeightLayoutCellByClass)
///**
// *  caculate cell size
// *
// *  @param aClass    cell's reuse identifier
// *  @param indexPath     indexPath
// *  @param configuration fill cell with you feed data
// *
// *  @return the caculated cell's height
// */
//- (CGSize)autoSizeForCellWithClass:(Class)aClass
//                             indexPath:(NSIndexPath *)indexPath
//                         configuration:
//(void (^)(__kindof UICollectionViewCell *))
//configuration;
//
///**
// *  caculate cell size with a fixed width
// *
// *  @param aClass    cell's reuse identifier
// *  @param indexPath     indexPath
// *  @param fixedWidth    your expect width
// *  @param configuration fill cell with you feed data
// *
// *  @return the caculated cell's height
// */
//
//- (CGSize)autoSizeForCellWithClass:(Class)aClass
//                             indexPath:(NSIndexPath *)indexPath
//                            fixedWidth:(CGFloat)fixedWidth
//                         configuration:
//(void (^)(__kindof UICollectionViewCell *cell))
//configuration;
//
///**
// *  caculate cell size with fixed height
// *
// *  @param aClass   cell's reuse identifier
// *  @param indexPath     indexPath
// *  @param fixedHeight    your expect height
// *  @param configuration fill cell with you feed data
// *
// *  @return the caculated cell's height
// */
//
//- (CGSize)autoSizeForCellWithWithClass:(Class)aClass
//                             indexPath:(NSIndexPath *)indexPath
//                           fixedHeight:(CGFloat)fixedHeight
//                         configuration:
//(void (^)(__kindof UICollectionViewCell *cell))
//configuration;
//
//
///**
// *  caculate cell size with fixed height
// *
// *  @param aClass    cell's reuse identifier
// *  @param indexPath     indexPath
// *  @param fixedWidth    your expect height
// *  @param configuration fill cell with you feed data
// *
// *  @return the caculated cell's height
// */
//
//- (CGSize)autoSizeForReusableViewHeightWithClass:(Class)aClass
//                                            kind:(NSString *)kind
//                                       indexPath:(NSIndexPath *)indexPath
//                                      fixedWidth:(CGFloat)fixedWidth
//                                   configuration:
//(void (^)(__kindof UICollectionReusableView *cell))
//configuration;
//@end
//
//NS_ASSUME_NONNULL_END
