//
//  UICollectionView+NXAdaptation.m
//  next_space_ios_arch
// 适配
//  Created by XXF on 2023/1/4.
//

#import "UICollectionView+NXAdaptation.h"
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation UICollectionView(NXAdaptation)

- (CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth
                   columnRange:(NSRange)columnRange{
    CGFloat spacing=0.0;
    CGFloat sectionPadding=fabs(self.contentInset.left)+fabs(self.contentInset.right);
    UICollectionViewFlowLayout *flowLayout =[UICollectionViewFlowLayout toKindOfClassObjectOrNilFrom:self.collectionViewLayout];
    if(flowLayout){
        spacing=flowLayout.minimumInteritemSpacing;
    }
    return [self getAdaptColumnWidth:expectColumnWidth withSectionPadding:sectionPadding withMinimumInteritemSpacing:spacing columnRange:columnRange];
}

-(CGFloat)getAdaptColumnWidth:(NSInteger)expectColumnWidth
                  columnRange:(NSRange)columnRange
               sectionAtIndex:(NSInteger)section{
    CGFloat spacing=0.0;
    CGFloat sectionPadding=fabs(self.contentInset.left)+fabs(self.contentInset.right);
    UICollectionViewFlowLayout *flowLayout =[UICollectionViewFlowLayout toKindOfClassObjectOrNilFrom:self.collectionViewLayout];
    if(flowLayout){
        spacing=flowLayout.minimumInteritemSpacing;
    }
    
    
    if([self.delegate conformsToProtocol:@protocol(UICollectionViewDelegateFlowLayout)]){
        id<UICollectionViewDelegateFlowLayout> _Nullable delegate=self.delegate;
        if([delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]){
            spacing= [delegate collectionView:self layout:self.collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
        }
        
        if([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]){
            UIEdgeInsets sectionEdge=[delegate collectionView:self layout:self.collectionViewLayout insetForSectionAtIndex:section];
            sectionPadding= fabs(sectionEdge.left)+fabs(sectionEdge.right);
        }
    
        return [self getAdaptColumnWidth:expectColumnWidth withSectionPadding:sectionPadding withMinimumInteritemSpacing:spacing
            columnRange:columnRange];
    }else{
        return [self getAdaptColumnWidth:expectColumnWidth withSectionPadding:sectionPadding withMinimumInteritemSpacing:spacing columnRange:columnRange];
    }
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
    return realWidth;
}
@end
