//
//  NXViewController.m
//  next_space_ios_arch
//
//  Created by Wenjinfu on 09/29/2022.
//  Copyright (c) 2022 Wenjinfu. All rights reserved.
//

#import "NXViewController.h"
#import <JLRoutes/JLRoutes.h>
#import  <YYKit/YYTextView.h>
//#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import <next_space_ios_arch/UIKeyCommand+Responsible.h>
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>

@interface NXViewController ()

@end

@implementation NXViewController


-(BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event{
    NSLog(@"===========>执行key %@ by %@  %@",command.input,self,event);
    return YES;
}


- (NSArray<UIKeyCommand *> *)keyCommands{
    NSLog(@"===============>快捷键注册了");
//    return @[ [UIKeyCommand commandWithTitle:@"全选" image:nil action:@selector(onKeyCommands) input:@"a" modifierFlags:UIKeyModifierCommand propertyList:Nil]];
    UIKeyCommand *command= [UIKeyCommand dispatchCommandWithTitle:@"全选" image:nil input:@"a" modifierFlags:UIKeyModifierCommand commandEvent:@"100"];
    return @[command];
}

- (BOOL)isFirstResponder{
    return NO;
}
- (BOOL)canBecomeFirstResponder{
    return NO;
}

- (void)viewDidLoad
{
    

    UITextField *text=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 800, 100)];
    text.placeholder=@"请输入";
    [self.view addSubview:text];

//    UITextField *text2=[[UITextField alloc] initWithFrame:CGRectMake(0, 100, 800, 100)];
//    text2.placeholder=@"请输入2";
//    [self.view addSubview:text2];
    
    YYTextView *text3=[[YYTextView alloc] initWithFrame:CGRectMake(0, 200, 800, 100)];
    text3.placeholderText=@"请输入3";
    [text3 becomeFirstResponder];
    [self.view addSubview:text3];
    
    
   UIView *findNext= [text.superview findFirstChildViewWithBlock:^BOOL(UIView * _Nonnull childView) {
        return [childView isTextInputView]&&[childView isDownForView:text];
   } deepQuery:YES];
    if(findNext){
        NSLog(@"==========>findYes");
    }else{
        NSLog(@"==========>findNO");
    }
    
    
    
    
    UITextView *text4=[[UITextView alloc] initWithFrame:CGRectMake(0, 300, 800, 100)];
    [self.view addSubview:text4];
    
    NSNumber *first=@1;
    NSNumber *second=nil;
    BOOL res=[first isEqual:second];
    NSLog(@"============>是否相等:%d",res);
    [super viewDidLoad];
    NSInteger age=1;
    switch (age) {
        case 1:
            NSLog(@"========>YY:1");
            break;
        case 10:
        case 20:
            NSLog(@"========>YY:10或者20");
            break;
        default:
            NSLog(@"========>YY:nil");
            break;
    }
//
//    [[self observeViewDidLoad] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"==============>observeViewDidLoad");
//    }];
//    [[self observeViewWillAppear] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"==============>observeViewWillAppear");
//    }];
//
//    [[self observeViewDidAppear] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"==============>observeViewDidAppear");
//    }];
//
//    [[self observeViewWillDisappear] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"==============>observeViewWillDisappear");
//    }];
    
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

//
//    [NXRouter addInterceptor:url priority:99 interceptor:^BOOL(NSDictionary<NSString *,id> *parameters) {
//        NSLog(@"=============>yes99");
//        return NO;
//    }];
//
//    [NXRouter addInterceptor:url priority:100 interceptor:^BOOL(NSDictionary<NSString *,id> *parameters) {
//        NSLog(@"=============>yes100");
//        return NO;
//    }];
//    [NXRouter removeInterceptor:url priority:100];
//    [NXRouter openURL:urlStr];

    [self testArraySpeed:0];
    [self testArraySpeed:10];
    [self testArraySpeed:100];
    [self testArraySpeed:1000];
    [self testArraySpeed:10000];
    [self testArraySpeed:100000];
    [self testArraySpeed:1000000];
}

-(void)testArraySpeed:(NSInteger)size{
    NSLog(@"===========>test speed:size %ld ",(long)size);
    NSMutableArray *array=[NSMutableArray array];
    for (int i = 0; i < size; i++) {
        [array addObject:@(i)];
    }
    NSTimeInterval startDate = NSDate.date.timeIntervalSince1970 * 1000;
    [array removeAllObjects];
    NSTimeInterval end= NSDate.date.timeIntervalSince1970 * 1000;
    NSLog(@"===========>t:remveAll :%lld ",(long long)(end - startDate));
    
    startDate = NSDate.date.timeIntervalSince1970 * 1000;
    array=[NSMutableArray array];
    end= NSDate.date.timeIntervalSince1970 * 1000;
    NSLog(@"===========>t:renew :%lld ",(long long)(end - startDate));
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
