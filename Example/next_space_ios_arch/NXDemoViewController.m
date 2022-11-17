//
//  NXViewController.m
//  next_space_ios_arch
//
//  Created by Wenjinfu on 09/29/2022.
//  Copyright (c) 2022 Wenjinfu. All rights reserved.
//

#import "NXDemoViewController.h"
#import <JLRoutes/JLRoutes.h>
#import  <YYKit/YYTextView.h>
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import <next_space_ios_arch/UIKeyCommand+Responsible.h>
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>
#import "NXViewController+Test.h"
#import "UIViewController+TestViewController.h"
#import "NXTestModalVC.h"

//@import next_space_ios_arch;


@interface NXDemoViewController ()<UIKeyCommanderProtocol,YYTextViewDelegate, UITextViewDelegate>

@end

@implementation NXDemoViewController

- (BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event originatingResponder:(UIResponder *)originatingResponder{
    NSLog(@"===========>执行key %@ by %@  %@ from:%@  %d",command.input,self.simpleDescription,event,originatingResponder.simpleDescription,self.canBecomeFirstResponder);
    return YES;
}


- (NSArray<UIKeyCommand *> *)keyCommands{
    NSLog(@"===============>快捷键注册了 by vc  %d",self.canBecomeFirstResponder);
    UIKeyCommand *command= [UIKeyCommand dispatchCommandWithTitle:@"全选" image:nil input:@"a" modifierFlags:UIKeyModifierCommand commandEvent:@"100"];
    return @[command,
             [UIKeyCommand dispatchKeyCommandWithInput:@"." modifierFlags:UIKeyModifierControl commandEvent:UIKeyInputLeftArrow],
             [UIKeyCommand dispatchKeyCommandWithInput:UIKeyInputEscape modifierFlags:0 commandEvent:UIKeyInputLeftArrow]
    ];
}
//
//- (BOOL)isFirstResponder{
//    return NO;
//}
- (BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)test{
    NSLog(@"============>收到:%@",[NSDate date]);
}
-(void)testThrott{
    [self throttleWithSelector:@selector(test) withObject:nil duration:0.5];
    [self throttleWithSelector:@selector(test) withObject:nil duration:0.5];
    [self throttleWithSelector:@selector(test) withObject:nil duration:0.5];
    [self throttleWithSelector:@selector(test) withObject:nil duration:0.5];
    [self throttleWithSelector:@selector(test) withObject:nil duration:0.5];
    [self throttleWithSelector:@selector(test) withObject:nil duration:0.5];
}

-(void)textViewDidChangeSelection:(UITextView *)textView{
    NSLog(@"=======>输入法:%@  %lld", [[textView textInputMode] primaryLanguage],(long long)[self isThirdPartyKeyboard]);
}
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"=======>输入法:%@  %lld", [[textView textInputMode] primaryLanguage],(long long)[self isThirdPartyKeyboard]);
}
//- (void)textViewDidChange:(YYTextView *)textView{
//    NSLog(@"=======>输入法:%@", [[textView textInputMode] primaryLanguage]);
//}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"==========>输入法___:(%ld,%ld) %@",(long)range.location,(long)range.length,text);
    return YES;
}


- (void)textViewDidBeginEditing:(YYTextView *)textView{
    NSLog(@"=======>输入法:%@  %lld", [[textView textInputMode] primaryLanguage],(long long)[self isThirdPartyKeyboard]);
}

// 方法二
- (BOOL)isThirdPartyKeyboard {
    UITextInputMode *currentInputMode = [[UIApplication sharedApplication] textInputMode];
    NSString *currentInputModeClass = NSStringFromClass([currentInputMode class]);
    if ([currentInputModeClass isEqualToString:@"UIKeyboardExtensionInputMode"]) {
        return YES;
    }
    return NO;
}

-(void)printView:(UIView *)view{
    NSLog(@"========>view:%@",view);
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self printView:obj];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIWindow * value in [[UIApplication sharedApplication].windows reverseObjectEnumerator]) {
        NSLog(@"========>view: window:%@",value);
        [value.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self printView:obj];
        }];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [[[RACSignal just:@"xxx"] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        NSLog(@"=================>yes:%@",value);
        return [RACSignal just:value];
    }] subscribe];
    
    [self setCanceledOnTouchOutside:NO];
    self.contentView.backgroundColor=UIColor.clearColor;
    [self testThrott];

    NSLog(@"=======>输入法 app:%@  %lld", [[self textInputMode] primaryLanguage],(long long)[self isThirdPartyKeyboard]);
    
    [RACObserve(UIApplication.sharedApplication, textInputContextIdentifier) subscribeNext:^(id  _Nullable x) {
        NSLog(@"=======>输入法监听 app:%@  %lld", [[self textInputMode] primaryLanguage],(long long)[self isThirdPartyKeyboard]);
    }];
  
    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 40, 300, 100)];
    btn.titleLabel.text=@"xxxx";
    btn.titleLabel.textColor=UIColor.blackColor;
    btn.backgroundColor=UIColor.yellowColor;
    [btn setEnabled:YES];
    [btn addTarget:self
       action:@selector(showModal)
  forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    NSLog(@"======>super:%@",self.view.superview);
    [self testvc];
    
    UITextField *text=[[UITextField alloc] initWithFrame:CGRectMake(0, 101, 300, 100)];
    text.placeholder=@"请输入";
    text.text=@"1";
    text.tag=1;
    [self.view addSubview:text];

    UITextField *text2=[[UITextField alloc] initWithFrame:CGRectMake(0, 201, 300, 100)];
    text2.placeholder=@"请输入2";
    text2.text=@"2";
    text2.tag=2;
    [self.view addSubview:text2];

    YYTextView *text3=[[YYTextView alloc] initWithFrame:CGRectMake(0, 302, 300, 100)];
    text3.placeholderText=@"请输入3";
    text3.text=@"3";
    text3.tag=3;
    text3.delegate=self;
    [text3 becomeFirstResponder];
    [self.view addSubview:text3];

    
    NSLog(@"======>IS:%d",self.canBecomeFirstResponder);
    NSArray<NSString *> *arra=@[@"x",@"x2",@"x3",@"3"];
  
    NSString *s=[arra firstObjectWithBlock:^BOOL(NSString * _Nonnull obj) {
        return [obj isEqual:@"x2"];
    }];
    NSLog(@"=========>find:%@",s);
    NSArray *filter=[arra filterObjectWithBlock:^BOOL(NSString * _Nonnull obj) {
        return [obj containsString:@"x"];
    }];
    NSLog(@"=========>find:%@",filter.lastObject);
    
    UITextView *text4=[[UITextView alloc] initWithFrame:CGRectMake(0, 410, 800, 100)];
    text4.text=@"4";
    text4.tag=4;
    text4.delegate=self;
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
    
    [self showModal];

}




-(void)showModal{
    [self.view endEditing:YES];
    UIViewController *popoverContent=[NXTestModalVC new];
    popoverContent.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    popoverContent.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:popoverContent animated:NO completion:nil];
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
