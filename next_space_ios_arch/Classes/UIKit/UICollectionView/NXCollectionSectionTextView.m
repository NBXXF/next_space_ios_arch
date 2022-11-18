//
//  NXCollectionSectionTextViewCollectionReusableView.m
//  next_space_ios_arch
//
//  Created by 1234 on 2022/11/18.
//

#import "NXCollectionSectionTextView.h"
#import <Masonry/Masonry.h>

@interface NXCollectionSectionTextView()
@property (nonatomic, strong) UILabel *textLabel;
@end
@implementation NXCollectionSectionTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.textLabel removeFromSuperview];
        [self.contentView addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.textLabel.superview);
        }];
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = UILabel.new;
        _textLabel.textColor=UIColor.blackColor;
        _textLabel.font = [UIFont systemFontOfSize:16];
        _textLabel.textAlignment=NSTextAlignmentCenter;
        [_textLabel sizeToFit];
    }
    return _textLabel;
}
@end
