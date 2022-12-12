//
//  MyCellCollectionViewCell.m
//  next_space_ios_arch_Example
//
//  Created by 1234 on 2022/12/9.
//

#import "MyCellCollectionViewCell.h"

@implementation MyCellCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self setupUI];
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.textview];
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.contentView);
    }];
}
- (UITextView *)textview{
    if(!_textview){
        _textview=UITextView.new;
        _textview.textColor=UIColor.blackColor;
        _textview.backgroundColor=UIColor.clearColor;
    }
    return _textview;
}
@end
