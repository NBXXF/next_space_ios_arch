//
//  UICollectionView+NXAdaptation.m
//  next_space_ios_arch
// 适配
//  Created by XXF on 2023/1/4.
//

#import "UICollectionView+NXAdaptation.h"

@implementation UICollectionView(NXAdaptation)

- (CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth
                   columnRange:(NSRange)columnRange{
    CGFloat spacing=0.0;
    if([self.collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
        spacing=((UICollectionViewFlowLayout *)self.collectionViewLayout).minimumInteritemSpacing;
    }
    return [self getAdaptColumnWidth:expectColumnWidth withSectionPadding:0 withMinimumInteritemSpacing:spacing columnRange:columnRange];
}

-(CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth
                  columnRange:(NSRange)columnRange
               sectionAtIndex:(NSInteger)section{
    if([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)]){
        id<UICollectionViewDelegateFlowLayout> _Nullable delegate=self.delegate;
        CGFloat minimumInteritemSpacing= [delegate collectionView:self layout:self.collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
        //用默认的
        if(minimumInteritemSpacing<=0.0){
            if([self.collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.class]){
                minimumInteritemSpacing=((UICollectionViewFlowLayout *)self.collectionViewLayout).minimumInteritemSpacing;
            }
        }
        UIEdgeInsets sectionEdge=[delegate collectionView:self layout:self.collectionViewLayout insetForSectionAtIndex:section];
        CGFloat sectionPadding= fabs(sectionEdge.left)+fabs(sectionEdge.right);
        return [self getAdaptColumnWidth:expectColumnWidth withSectionPadding:sectionPadding withMinimumInteritemSpacing:minimumInteritemSpacing
            columnRange:columnRange];
    }
    return [self getAdaptColumnWidth:expectColumnWidth columnRange:columnRange];
}

- (CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth withSectionPadding:(CGFloat)sectionPadding withMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                   columnRange:(NSRange)columnRange{
    CGFloat padding=fabs(self.contentInset.left)+fabs(self.contentInset.right)+sectionPadding;
    CGFloat totalWidth=self.frame.size.width-padding;
    
    
    NSInteger column= (NSInteger) (floor(totalWidth/expectColumnWidth));
   
    //循环递减列数量
    BOOL flag=(expectColumnWidth*column+(column-1)*minimumInteritemSpacing)<=totalWidth;
    while (!flag&&column>1) {
        column--;
        flag=(expectColumnWidth*column+(column-1)*minimumInteritemSpacing)<=totalWidth;
    }

    CGFloat minColumn=columnRange.location;
    CGFloat maxColumn=NSMaxRange(columnRange);
    
    NSAssert(minColumn<maxColumn&&minColumn>=1, @"columnRange参数不合法");
    
    if(column<minColumn){
        column=minColumn;
    }else if(column>maxColumn){
        column=maxColumn;
    }
    CGFloat realWidth=(totalWidth-(column-1)*minimumInteritemSpacing)/column;
    NSString * str = [NSString stringWithFormat:@"%.1f",realWidth];
    return MAX(floor([str floatValue]), 0.1);
}
@end
