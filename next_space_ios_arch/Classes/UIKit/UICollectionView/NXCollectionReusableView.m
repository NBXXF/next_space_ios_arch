//
//  NXCollectionReusableView.m
//  next_space_ios_arch
//  规范section
//  Created by 1234 on 2022/11/18.
//

#import "NXCollectionReusableView.h"

@interface NXCollectionReusableView()
@property (nonatomic, strong) UIView *contentView;
@end


@implementation NXCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView removeFromSuperview];
        [self addSubview:self.contentView];
        self.contentView.frame=self.bounds;
        
        [self.backgroundView removeFromSuperview];
        self.backgroundView=UIView.new;
        self.backgroundView.backgroundColor=UIColor.clearColor;
        [self insertSubview:self.backgroundView atIndex:0];
    }
    return self;
}


- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor=UIColor.clearColor;
    }
    return _contentView;
}

@end
