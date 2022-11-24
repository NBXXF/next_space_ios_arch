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
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>

@interface NXTestModalVC()
@property (nonatomic, strong)UIView *iv;
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

    
    self.iv=UIView.new;
    self.iv.backgroundColor=UIColor.orangeColor;
    [self.contentView addSubview:self.iv];
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
      //  make.top.equalTo(self.contentView).offset(40);
        make.top.equalTo(self.view).offset(260).priorityLow();
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(100);
    }];
    self.iv.tag=1;
    
    UIView *next=UIView.new;
    next.backgroundColor=UIColor.blueColor;
    [self.contentView addSubview:next];
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.iv.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    next.tag=2;
    self.confirmBtn.tag=3;
    [self.contentView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.equalTo(@(40));
    }];
    
    
    NSUserDefaults *t1= [[NSUserDefaults alloc] initWithSuiteName:@"test1"];
    [self clear:t1];
    [self insertCount:t1 andCount:100];
    [self testTime:t1];
    
    
    NSUserDefaults *t2= [[NSUserDefaults alloc] initWithSuiteName:@"test2"];
    [self clear:t2];
    [self insertCount:t2 andCount:10000];
    [self testTime:t2];
}

-(void)testTime:(NSUserDefaults *) userDefatluts{
    NSDate *start=[NSDate date];
    NSString *s=[userDefatluts stringForKey:@"99"];
    NSDate *end=[NSDate date];
    NSLog(@"===========>take by(%@):%@ %f",userDefatluts,s,[end timeIntervalSinceDate:start]);
}

-(void)insertCount:(NSUserDefaults *) userDefatluts andCount:(NSInteger)count;{
    for(int i =0;i<count;i++){
        [userDefatluts setObject:[NSString stringWithFormat:@"data_%d",i] forKey:[NSString stringWithFormat:@"%d",i]];
    }
}

-(void)clear:(NSUserDefaults *) userDefatluts{
    NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        [userDefatluts removeObjectForKey:key];
        [userDefatluts synchronize];
    }
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
    if(self.iv.isVisible){
        [self.iv setVisibility:UIViewVisibilityGone];
    }else{
        [self.iv setVisibility:UIViewVisibilityVisible];
    }
   // [self popOrDismissViewControllerAnimated:YES completion:nil];
}

@end
