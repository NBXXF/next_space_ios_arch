//
//  NXTestModalVC.m
//  next_space_ios_arch_Example
//
//  Created by XXF on 2022/11/3.
//  Copyright © 2022 Wenjinfu. All rights reserved.
//

#import "NXTestModalVC.h"
#import "NXTestModal2VC.h"
#import <Masonry/Masonry.h>

@interface NXTestModalVC()
@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation NXTestModalVC


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setComponentCornerRadius:10];
    [self setComponentAlpha:0.2];
    [self setComponentShadowOpacity:0.2];
    [self setComponentSize:CGSizeMake(300, 300) gravity:NXComponentGravityCenter];
    [self setCanceledOnTouchOutside:YES];

    
    UIView *iv=UIView.new;
    iv.backgroundColor=UIColor.orangeColor;
    [self.contentView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.equalTo(@(40));
    }];
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"知道了" forState:UIControlStateNormal];
        _confirmBtn.backgroundColor=UIColor.yellowColor;
        _confirmBtn.layer.cornerRadius = 6.0;
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

-(void)close{
    [self popOrDismissViewControllerAnimated:YES completion:nil];
}

@end
