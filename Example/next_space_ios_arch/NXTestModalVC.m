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

@implementation NXTestModalVC


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setComponentCornerRadius:10];
    [self setComponentAlpha:0.2];
    [self setComponentSize:CGSizeMake(300, 300) gravity:NXComponentGravityCenter];
   // [self setCanceledOnTouchOutside:NO];

    
    UIView *iv=UIView.new;
    iv.backgroundColor=UIColor.orangeColor;
    [self.contentView addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];

    

}

@end
