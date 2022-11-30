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
#import "NXBean.h"
#import <YYModel/YYModel.h>

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


    [NXKeyValueService.shared setString:@"xx" forKey:@"name" differUser:NO];
    [self testMMKVSpped];
    NSString *str= [NXKeyValueService.shared stringForKey:@"name" defaultValue:@"ddd" differUser:NO];
    NSLog(@"=========>存储了:%@",str);
    
    [[NXKeyValueService.shared observeChangeWithKey:@"name" differUser:NO] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"=========>存储了改变了:%@",[NXKeyValueService.shared stringForKey:@"name" defaultValue:@"ddd2" differUser:NO]);
    }];
    
    [NXKeyValueService.shared setString:@"xx33" forKey:@"name" differUser:NO];
    [NXKeyValueService.shared setString:@"xx44" forKey:@"name" differUser:NO];
    
    
    NXBean *ben=NXBean.new;
    ben.name=@"张三";
    [NXKeyValueService.shared setObjectToJson:ben forKey:@"xxx" differUser:NO];
    NSLog(@"=========>ben1:%@ _ %@",ben.simpleDescription,ben.name);
    
    ben=(NXBean *)[NXKeyValueService.shared objectFromJson:NXBean.class forKey:@"xxx" defaultValue:nil differUser:NO ];
    NSLog(@"=========>ben2:%@ _ %@",ben.simpleDescription,ben.name);
    

    
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:ben];
    data=[ben yy_modelToJSONData];
    
    [self testSpeed];
}

-(void)testSpeed{
    NXBean *ben=NXBean.new;
    ben.name=@"张三";
    
    NSTimeInterval start=[NSDate date].timeIntervalSince1970;
    NSData *data;
    for(NSInteger i=0;i<1000;i++){
        data=[NSKeyedArchiver archivedDataWithRootObject:ben];
    }
    NSTimeInterval end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take ser by nscoding:%f",(end-start));
    
    start=[NSDate date].timeIntervalSince1970;
    for(NSInteger i=0;i<1000;i++){
        NXBean *ben=[NSKeyedUnarchiver unarchivedObjectOfClass:NXBean.class fromData:data error:nil];
    }
    end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take deser by nscoding:%f",(end-start));
    
    
    start=[NSDate date].timeIntervalSince1970;
    for(NSInteger i=0;i<1000;i++){
        data=[ben yy_modelToJSONData];
    }
    end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take ser by json:%f",(end-start));
    
    start=[NSDate date].timeIntervalSince1970;
    for(NSInteger i=0;i<1000;i++){
        NXBean *ben=[NXBean yy_modelWithJSON:data];
    }
    end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take deser by json:%f",(end-start));
    
    
}

-(void)testMMKVSpped{
    NSTimeInterval start=[NSDate date].timeIntervalSince1970;
    for(NSInteger i=0;i<1000;i++){
        NSString *s= [NSString stringWithFormat:@"xx:%ld",(long)i];
        [NXKeyValueService.shared setString:@"xx" forKey:s differUser:NO];
    }
    NSTimeInterval end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take write by MMKV:%f",(end-start));
    
    start=[NSDate date].timeIntervalSince1970;
    for(NSInteger i=0;i<1000;i++){
        NSString *s= [NSString stringWithFormat:@"xx:%ld",(long)i];
        [NSUserDefaults.standardUserDefaults setObject:@"xx" forKey:s];
    }
    end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take write by NSUserDefaults:%f",(end-start));
    
    start=[NSDate date].timeIntervalSince1970;
    for(NSInteger i=0;i<1000;i++){
        NSString *s= [NSString stringWithFormat:@"xx:%ld",(long)i];
        [NSUserDefaults.standardUserDefaults stringForKey:@"name"];
    }
    end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take read by NSUserDefaults:%f",(end-start));
    
    
    start=[NSDate date].timeIntervalSince1970;
    for(NSInteger i=0;i<1000;i++){
        NSString *s= [NSString stringWithFormat:@"xx:%ld",(long)i];
        [NXKeyValueService.shared stringForKey:@"name" defaultValue:nil differUser:NO];
    }
    end=[NSDate date].timeIntervalSince1970;
    NSLog(@"=============>take read by MMKV:%f",(end-start));
    
    
  
    
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
