////
////  UICollectionView+NXAutoHeightLayoutCell.h
////  next_space_ios_arch
////  cell自适应框架
////  Created by XXF on 2022/11/18.
////
//
//#import "UICollectionView+NXAutoHeightLayoutCell.h"
//#import <objc/runtime.h>
//
//typedef NS_ENUM(NSUInteger, AutoDynamicSizeCaculateType) {
//    AutoDynamicSizeCaculateTypeSize = 0,
//    AutoDynamicSizeCaculateTypeHeight,
//    AutoDynamicSizeCaculateTypeWidth
//};
//
//#define AutoLayoutCellInvalidateValue [NSValue valueWithCGSize:CGSizeZero]
//@implementation UICollectionView(NXAutoHeightLayoutCell)
//
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self swizzlingMethods];
//    });
//}
//
//+ (void)swizzlingMethods {
//    SEL selectors[] = {
//        
//        @selector(registerNib:forSupplementaryViewOfKind:withReuseIdentifier:),
//        @selector(registerClass:forSupplementaryViewOfKind:withReuseIdentifier:),
//        @selector(registerNib:forCellWithReuseIdentifier:),
//        @selector(registerClass:forCellWithReuseIdentifier:),
//        @selector(reloadData),
//        @selector(reloadSections:),
//        @selector(deleteSections:),
//        @selector(moveSection:toSection:),
//        @selector(reloadItemsAtIndexPaths:),
//        @selector(deleteItemsAtIndexPaths:),
//        @selector(moveItemAtIndexPath:toIndexPath:)
//    };
//    
//    for (int i = 0; i < sizeof(selectors) / sizeof(SEL); i++) {
//        SEL originalSelector = selectors[i];
//        SEL swizzledSelector = NSSelectorFromString([@"auto_"
//                                                     stringByAppendingString:NSStringFromSelector(originalSelector)]);
//        
//        Method originalMethod = class_getInstanceMethod(self, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
//        
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//}
//
//- (CGSize)autoSizeForCellWithIdentifier:(NSString *)identifier
//                             indexPath:(NSIndexPath *)indexPath
//                         configuration:
//(void (^)(__kindof UICollectionViewCell *))
//configuration {
//    return [self autoSizeForCellWithIdentifier:identifier
//                                    indexPath:indexPath
//                                   fixedValue:0
//                                 caculateType:AutoDynamicSizeCaculateTypeSize
//                                configuration:configuration];
//}
//
//- (CGSize)autoSizeForCellWithIdentifier:(NSString *)identifier
//                             indexPath:(NSIndexPath *)indexPath
//                            fixedWidth:(CGFloat)fixedWidth
//                         configuration:
//(void (^)(__kindof UICollectionViewCell *))
//configuration {
//    return [self autoSizeForCellWithIdentifier:identifier
//                                    indexPath:indexPath
//                                   fixedValue:fixedWidth
//                                 caculateType:AutoDynamicSizeCaculateTypeWidth
//                                configuration:configuration];
//}
//
//- (CGSize)autoSizeForCellWithIdentifier:(NSString *)identifier
//                             indexPath:(NSIndexPath *)indexPath
//                           fixedHeight:(CGFloat)fixedHeight
//                         configuration:
//(void (^)(__kindof UICollectionViewCell *))
//configuration {
//    return [self autoSizeForCellWithIdentifier:identifier
//                                    indexPath:indexPath
//                                   fixedValue:fixedHeight
//                                 caculateType:AutoDynamicSizeCaculateTypeHeight
//                                configuration:configuration];
//}
//
//- (CGSize)autoSizeForCellWithIdentifier:(NSString *)identifier
//                             indexPath:(NSIndexPath *)indexPath
//                            fixedValue:(CGFloat)fixedValue
//                          caculateType:(AutoDynamicSizeCaculateType)caculateType
//                         configuration:
//(void (^)(__kindof UICollectionViewCell *))
//configuration {
//    BOOL hasCache = [self hasCacheAtIndexPath:indexPath];
//    if (hasCache) {
//        if (![[self sizeCacheAtIndexPath:indexPath]
//              isEqualToValue:AutoLayoutCellInvalidateValue]) {
//            return [[self sizeCacheAtIndexPath:indexPath] CGSizeValue];
//        }
//    }
//    
//    // has no size chche
//    UICollectionViewCell *cell =
//    [self templeCaculateCellWithIdentifier:identifier];
//    configuration(cell);
//    CGSize size = CGSizeMake(fixedValue, fixedValue);
//    if (caculateType != AutoDynamicSizeCaculateTypeSize) {
//        NSLayoutAttribute attribute = caculateType == AutoDynamicSizeCaculateTypeWidth
//        ? NSLayoutAttributeWidth
//        : NSLayoutAttributeHeight;
//        NSLayoutConstraint *tempConstraint =
//        [NSLayoutConstraint constraintWithItem:cell.contentView
//                                     attribute:attribute
//                                     relatedBy:NSLayoutRelationEqual
//                                        toItem:nil
//                                     attribute:NSLayoutAttributeNotAnAttribute
//                                    multiplier:1
//                                      constant:fixedValue];
//        [cell.contentView addConstraint:tempConstraint];
//        size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        [cell.contentView removeConstraint:tempConstraint];
//    } else {
//        size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    }
//    
//    NSMutableArray *sectionCache = [self sizeCache][indexPath.section];
//    NSValue *sizeValue = [NSValue valueWithCGSize:size];
//    if (hasCache) {
//        [sectionCache replaceObjectAtIndex:indexPath.row withObject:sizeValue];
//    } else {
//        [sectionCache insertObject:sizeValue atIndex:indexPath.row];
//    }
//    return size;
//}
//
//#pragma mark - swizzled methods
//
//- (void)auto_registerClass:(Class)cellClass
//forCellWithReuseIdentifier:(NSString *)identifier {
//    [self auto_registerClass:cellClass forCellWithReuseIdentifier:identifier];
//    
//    id cell = [[cellClass alloc] initWithFrame:CGRectZero];
//    NSMutableDictionary *templeCells = [self templeCells];
//    templeCells[identifier] = cell;
//}
//
//- (void)auto_registerNib:(UINib *)nib
//forCellWithReuseIdentifier:(NSString *)identifier {
//    [self auto_registerNib:nib forCellWithReuseIdentifier:identifier];
//    id cell = [[nib instantiateWithOwner:nil options:nil] lastObject];
//    NSMutableDictionary *templeCells = [self templeCells];
//    templeCells[identifier] = cell;
//}
//
//- (void)auto_registerClass:(Class)viewClass
//forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier {
//    
//    [self auto_registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
//    id cell = [[viewClass alloc] initWithFrame:CGRectZero];
//    NSMutableDictionary *templeCells = [self templeCells];
//    templeCells[identifier] = cell;
//    
//}
//
//- (void)auto_registerNib:(UINib *)nib
//forSupplementaryViewOfKind:(NSString *)kind withReuseIdentifier:(NSString *)identifier {
//    
//    [self auto_registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
//    id cell = [[nib instantiateWithOwner:nil options:nil] lastObject];
//    NSMutableDictionary *templeCells = [self templeCells];
//    templeCells[identifier] = cell;
//}
//
//
//
//#pragma mark - section changes
//
//- (void)auto_reloadSections:(NSIndexSet *)sections {
//    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
//        if (idx < [self sizeCache].count) {
//            [[self sizeCache] replaceObjectAtIndex:idx withObject:@[].mutableCopy];
//        }
//    }];
//    [self auto_reloadSections:sections];
//}
//
//- (void)auto_deleteSections:(NSIndexSet *)sections {
//    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
//        if (idx < [self sizeCache].count) {
//            [[self sizeCache] removeObjectAtIndex:idx];
//        }
//    }];
//    [self auto_deleteSections:sections];
//}
//
//- (void)auto_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
//    if (section < [self sizeCache].count && newSection < [self sizeCache].count) {
//        [[self sizeCache] exchangeObjectAtIndex:section withObjectAtIndex:newSection];
//    }
//    [self auto_moveSection:section toSection:newSection];
//}
//
//#pragma mark - item changes
//
//- (void)auto_deleteItemsAtIndexPaths:(NSArray *)indexPaths {
//    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx,
//                                             BOOL *stop) {
//        if ([self.sizeCache count] > obj.section) {
//            NSMutableArray *section = [self sizeCache][obj.section];
//            [section removeObjectAtIndex:obj.row];
//        }
//    }];
//    [self auto_deleteItemsAtIndexPaths:indexPaths];
//}
//
//- (void)auto_reloadItemsAtIndexPaths:(NSArray *)indexPaths {
//    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx,
//                                             BOOL *stop) {
//        if ([self.sizeCache count] > obj.section) {
//            NSMutableArray *section = [self sizeCache][obj.section];
//            section[obj.row] = AutoLayoutCellInvalidateValue;
//        }
//    }];
//    [self auto_reloadItemsAtIndexPaths:indexPaths];
//}
//
//- (void)auto_moveItemAtIndexPath:(NSIndexPath *)indexPath
//                   toIndexPath:(NSIndexPath *)newIndexPath {
//    if ([self hasCacheAtIndexPath:indexPath] &&
//        [self hasCacheAtIndexPath:newIndexPath]) {
//        NSValue *indexPathSizeValue = [self sizeCacheAtIndexPath:indexPath];
//        NSValue *newIndexPathSizeValue = [self sizeCacheAtIndexPath:newIndexPath];
//        
//        NSMutableArray *section1 = [self sizeCache][indexPath.section];
//        NSMutableArray *section2 = [self sizeCache][newIndexPath.section];
//        [section1 replaceObjectAtIndex:indexPath.row
//                            withObject:newIndexPathSizeValue];
//        [section2 replaceObjectAtIndex:newIndexPath.row
//                            withObject:indexPathSizeValue];
//    }
//    [self auto_moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
//}
//
//- (void)auto_reloadData {
//    [[self sizeCache] removeAllObjects];
//    [self auto_reloadData];
//}
//
//#pragma mark - private methods
//
//- (NSMutableDictionary *)templeCells {
//    NSMutableDictionary *templeCells = objc_getAssociatedObject(self, _cmd);
//    if (templeCells == nil) {
//        templeCells = @{}.mutableCopy;
//        objc_setAssociatedObject(self, _cmd, templeCells,
//                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return templeCells;
//}
//
//- (id)templeCaculateCellWithIdentifier:(NSString *)identifier {
//    NSMutableDictionary *templeCells = [self templeCells];
//    id cell = [templeCells objectForKey:identifier];
//    if (cell == nil) {
//        NSDictionary *cellNibDict = [self valueForKey:@"_cellNibDict"];
//        UINib *cellNIb = cellNibDict[identifier];
//        cell = [[cellNIb instantiateWithOwner:nil options:nil] lastObject];
//        templeCells[identifier] = cell;
//    }
//    
//    return cell;
//}
//
//#pragma mark - cache methods
//
//- (NSMutableArray *)sizeCache {
//    NSMutableArray *cache = objc_getAssociatedObject(self, _cmd);
//    if (cache == nil) {
//        cache = @[].mutableCopy;
//        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN);
//    }
//    return cache;
//}
//
//- (BOOL)hasCacheAtIndexPath:(NSIndexPath *)indexPath {
//    BOOL hasCache = NO;
//    NSMutableArray *cacheArray = [self sizeCache];
//    if (cacheArray.count > indexPath.section) {
//        if ([cacheArray[indexPath.section] count] > indexPath.row) {
//            hasCache = YES;
//        }
//    } else {
//        NSUInteger index = cacheArray.count;
//        for (; index < indexPath.section + 1; index++) {
//            [cacheArray addObject:@[].mutableCopy];
//        }
//    }
//    
//    return hasCache;
//}
//
//- (NSValue *)sizeCacheAtIndexPath:(NSIndexPath *)indexPath {
//    NSValue *sizeValue = [self sizeCache][indexPath.section][indexPath.row];
//    return sizeValue;
//}
//
//
//- (CGSize)autoSizeForReusableViewHeightIdentifier:(NSString *)identifier
//                                             kind:(NSString *)kind
//                                       indexPath:(NSIndexPath *)indexPath
//                                      fixedWidth:(CGFloat)fixedWidth
//                                   configuration:(void (^)(__kindof UICollectionReusableView *))configuration {
//    
//    return [self autoSizeForReusableViewWithIdentifier:identifier
//                                            indexPath:indexPath
//                                           fixedValue:fixedWidth
//                                         caculateType:AutoDynamicSizeCaculateTypeWidth
//                                        configuration:configuration];
//}
//
//
//
//- (CGSize)autoSizeForReusableViewWithIdentifier:(NSString *)identifier
//                                     indexPath:(NSIndexPath *)indexPath
//                                    fixedValue:(CGFloat)fixedValue
//                                  caculateType:(AutoDynamicSizeCaculateType)caculateType
//                                 configuration:
//(void (^)(__kindof UICollectionReusableView *))
//configuration {
//    BOOL hasCache = [self hasCacheAtIndexPath:indexPath];
//    if (hasCache) {
//        if (![[self sizeCacheAtIndexPath:indexPath]
//              isEqualToValue:AutoLayoutCellInvalidateValue]) {
//            return [[self sizeCacheAtIndexPath:indexPath] CGSizeValue];
//        }
//    }
//    
//    // has no size chche
//    UICollectionReusableView *cell =
//    [self templeCaculateCellWithIdentifier:identifier];
//    configuration(cell);
//    CGSize size = CGSizeMake(fixedValue, fixedValue);
//    if (caculateType != AutoDynamicSizeCaculateTypeSize) {
//        NSLayoutAttribute attribute = caculateType == AutoDynamicSizeCaculateTypeWidth
//        ? NSLayoutAttributeWidth
//        : NSLayoutAttributeHeight;
//        NSLayoutConstraint *tempConstraint =
//        [NSLayoutConstraint constraintWithItem:cell
//                                     attribute:attribute
//                                     relatedBy:NSLayoutRelationEqual
//                                        toItem:nil
//                                     attribute:NSLayoutAttributeNotAnAttribute
//                                    multiplier:1
//                                      constant:fixedValue];
//        [cell addConstraint:tempConstraint];
//        size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        [cell removeConstraint:tempConstraint];
//    } else {
//        size = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    }
//    
//    NSMutableArray *sectionCache = [self sizeCache][indexPath.section];
//    NSValue *sizeValue = [NSValue valueWithCGSize:size];
//    if (hasCache) {
//        [sectionCache replaceObjectAtIndex:indexPath.row withObject:sizeValue];
//    } else {
//        [sectionCache insertObject:sizeValue atIndex:indexPath.row];
//    }
//    return size;
//}
//
//@end
