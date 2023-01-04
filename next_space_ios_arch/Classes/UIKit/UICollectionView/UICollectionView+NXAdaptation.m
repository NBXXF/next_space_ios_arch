//
//  UICollectionView+NXAdaptation.m
//  next_space_ios_arch
// 适配
//  Created by XXF on 2023/1/4.
//

#import "UICollectionView+NXAdaptation.h"

@implementation UICollectionView(NXAdaptation)

- (CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth
                     minColumn:(NSInteger)minColumn{
    CGFloat spacing=0.0;
    if([self.collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
        spacing=((UICollectionViewFlowLayout *)self.collectionViewLayout).minimumInteritemSpacing;
    }
    return [self getAdaptColumnWidth:expectColumnWidth withSectionPadding:0 withMinimumInteritemSpacing:spacing minColumn:minColumn];
}

- (CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth insetForSectionAtIndex:(NSInteger)section
                     minColumn:(NSInteger)minColumn{
    if([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)]){
        id<UICollectionViewDelegateFlowLayout> _Nullable delegate=self.delegate;
        CGFloat minimumInteritemSpacing= [delegate collectionView:self layout:self.collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
        UIEdgeInsets sectionEdge=[delegate collectionView:self layout:self.collectionViewLayout insetForSectionAtIndex:section];
        CGFloat sectionPadding= fabs(sectionEdge.left)+fabs(sectionEdge.right);
        return [self getAdaptColumnWidth:expectColumnWidth withSectionPadding:sectionPadding withMinimumInteritemSpacing:minimumInteritemSpacing
            minColumn:minColumn];
    }
    return [self getAdaptColumnWidth:expectColumnWidth minColumn:minColumn];
}


- (CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth withSectionPadding:(CGFloat)sectionPadding withMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                     minColumn:(NSInteger)minColumn{
    CGFloat padding=fabs(self.contentInset.left)+fabs(self.contentInset.right)+sectionPadding;
    CGFloat totalWidth=self.frame.size.width-padding;
    
    
    NSInteger column= (NSInteger) (floor(totalWidth/expectColumnWidth));
    //优先级为minColumn 最高
    if(column<=minColumn){
        CGFloat realColumnWidth=totalWidth/column;
        BOOL flag=(realColumnWidth*column+(column-1)*minimumInteritemSpacing)<=totalWidth;
        if(flag){
            return realColumnWidth;
        }
    }
    
    //循环递减列数量
    CGFloat realColumnWidth=totalWidth/column;
    BOOL flag=(realColumnWidth*column+(column-1)*minimumInteritemSpacing)<=totalWidth;
    while (!flag&&column>1) {
        column--;
        realColumnWidth=self.frame.size.width/column;
        flag=(realColumnWidth*column+(column-1)*minimumInteritemSpacing)<=totalWidth;
    }
    return realColumnWidth;
}
@end
