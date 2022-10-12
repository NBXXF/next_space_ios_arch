//
//  NXViewController.m
//  next_space_ios_arch
//
//  Created by Wenjinfu on 09/29/2022.
//  Copyright (c) 2022 Wenjinfu. All rights reserved.
//

#import "NXViewController.h"
#import <JLRoutes/JLRoutes.h>
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>

@interface NXViewController ()

@end

@implementation NXViewController


- (void)viewDidLoad
{

    [super viewDidLoad];
    [[self observeViewDidLoad] subscribeNext:^(id  _Nullable x) {
        NSLog(@"==============>observeViewDidLoad");
    }];
    [[self observeViewWillAppear] subscribeNext:^(id  _Nullable x) {
        NSLog(@"==============>observeViewWillAppear");
    }];
    
    [[self observeViewDidAppear] subscribeNext:^(id  _Nullable x) {
        NSLog(@"==============>observeViewDidAppear");
    }];
    
    [[self observeViewWillDisappear] subscribeNext:^(id  _Nullable x) {
        NSLog(@"==============>observeViewWillDisappear");
    }];
    
//    [[self rac_signalForSelector:@selector(viewDidAppear:)] subscribeNext:^(id x) {
//        NSLog(@"=============>收到1:%@",x);
//     }];
    
//    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
//        NSLog(@"=============>收到1:%@",x);
//     }];
//    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
//        NSLog(@"=============>收到1dd:%@",x);
//     }];
    NSArray<NSNumber *> *array = [NSArray arrayWithObjects:@(1),@(4),@(123),@(789),@(3),nil];
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber * obj2) {
       //这里的代码可以参照上面compare:默认的排序方法，也可以把自定义的方法写在这里，给对象排序
            NSComparisonResult result = [obj2 compare:obj1];
            return result;
        }];
        NSLog(@"排序后:%@",sortedArray.firstObject);
    
   // [NXRouter openURL:@"test"];
    

    int flag_default=1<<0;
    int flag_test=1<<1;
    int flag_test2=1<<20;
    NSLog(@"============>flag_default:%d",flag_default);
    NSLog(@"============>flag_test:%d",flag_test);
    NSLog(@"============>flag_test2:%d",flag_test2);
    
    int flags=flag_test|flag_test2|flag_default;
    
    
    [self printContains:flags fl:flag_default];
    [self printContains:flags fl:flag_test];
    [self printContains:flags fl:flag_test2];
    
    [self printContains:flags fl:1<<4];
    [self printContains:flags fl:1<<5];
    
    
    
    
    for(int i=0;i<1000;i++){
       //[self printContains:flag fl:i];
    }
    
    NSString *url=@"/xxxxx";
    NSString *urlStr=@"/xxxxx?name=jack";

        
    [NXRouter addInterceptor:url priority:99 interceptor:^BOOL(NSDictionary<NSString *,id> *parameters) {
        NSLog(@"=============>yes99");
        return NO;
    }];
    
    [NXRouter addInterceptor:url priority:100 interceptor:^BOOL(NSDictionary<NSString *,id> *parameters) {
        NSLog(@"=============>yes100");
        return NO;
    }];
    [NXRouter removeInterceptor:url priority:100];
    [NXRouter openURL:urlStr];

}


-(void)printContains:(int)flags fl:(int)currentFlag{
    if((currentFlag & flags)!=0){
        NSLog(@"============>包含:%d",currentFlag);
    }
}
@end


@interface User : NSObject
-(void)test;
@end

@implementation User

- (void)test{
   
}

@end
