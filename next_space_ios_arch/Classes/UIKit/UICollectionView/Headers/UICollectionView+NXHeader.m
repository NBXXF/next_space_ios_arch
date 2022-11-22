//
//  UICollectionView+NXHeader.m
//  next_space_ios_arch
//  增加header机制
//  Created by xxf on 2022/11/18.
//

#import "UICollectionView+NXHeader.h"
#import "NSArray+AppArch.h"
#import <Masonry/Masonry.h>

@implementation UICollectionView(NXHeader)

- (NXCollectionViewHeaderView *)collectionHeaderView{
    return [self.subviews firstObjectWithBlock:^BOOL(__kindof UIView * _Nonnull obj) {
        return ![obj isKindOfClass:NXCollectionViewHeaderView.class];
    }];
}
- (void)setCollectionHeaderView:(NXCollectionViewHeaderView *)collectionHeaderView headerHeight:(CGFloat)headerHeight{
    //先移除
    [collectionHeaderView removeFromSuperview];
    [self.collectionHeaderView removeFromSuperview];
    
    CGFloat absHeaderHeight=fabs(headerHeight);
    self.contentInset=UIEdgeInsetsMake(absHeaderHeight, 0, 0, 0);
    [self addSubview:collectionHeaderView];
    [collectionHeaderView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(absHeaderHeight);
        make.top.equalTo(self).offset(-absHeaderHeight);
    }];
}
@end
