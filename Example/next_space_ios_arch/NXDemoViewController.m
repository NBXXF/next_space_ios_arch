//
//  NXViewController.m
//  next_space_ios_arch
//
//  Created by Wenjinfu on 09/29/2022.
//  Copyright (c) 2022 Wenjinfu. All rights reserved.
//

#import "NXDemoViewController.h"
#import <JLRoutes/JLRoutes.h>
#import  <YYText/YYText.h>
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import <next_space_ios_arch/UIKeyCommand+Responsible.h>
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import <next_space_ios_arch/next_space_ios_arch-Swift.h>
#import "NXViewController+Test.h"
#import "UIViewController+TestViewController.h"
#import "NXTestModalVC.h"
#import <Masonry/Masonry.h>
#import "NXTestFlowLayoutViewController.h"
#import "NXTestRAC.h"
//#import <YYModel/YYModel.h>

//@import next_space_ios_arch;


@interface NXDemoViewController ()<UIKeyCommanderProtocol,YYTextViewDelegate, UITextViewDelegate>
@property(nonatomic,strong) RACSubject *changeSubject;
@property(nonatomic,strong) NXTestRAC *robj;

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
   NSString *a= [NSFileManager.externalDocDir stringByAppendingPathComponent:@"aaaa/a.txt"];
    NSString *b= [NSFileManager.externalDocDir stringByAppendingPathComponent:@"sgsfg/dshghds/"];
    BOOL as=  [NSFileManager.defaultManager createPathDirectoryAtPath:b withIntermediateDirectories:YES attributes:nil error:nil];
    NSLog(@"===========>dir:externalDocDir:%@",[NSFileManager externalDocDir]);
    NSLog(@"===========>dir:docDir:%@",[NSFileManager docDir]);
    NSLog(@"===========>dir:cachesDir:%@",[NSFileManager cachesDir]);
    NSLog(@"===========>dir:preferenceDir:%@",[NSFileManager externalDocDir]);
    NSLog(@"===========>dir:tmpDir:%@",[NSFileManager tmpDir]);


    
    NSLog(@"===========>used:%lld  total:%lld", [PerformanceCalculator  memoryUsed]/1024/1204,
          [PerformanceCalculator  memoryTotal]/1024/1024);
    
    [self nx_setAssociatedObject:@YES forKey:@"test"];
    id ab=[self nx_getAssociatedObject:@"test"];
    
    [self nx_setAssociatedObject:@"376643" forKey:@"test1"];
    id ab2=[self nx_getAssociatedObject:@"test1"];
    
    for (UIWindow * value in [[UIApplication sharedApplication].windows reverseObjectEnumerator]) {
        NSLog(@"========>view: window:%@",value);
        [value.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self printView:obj];
        }];
    }
}

-(void)testUrl:(NSString *)urlStr{
    NSURLComponents *url= [[NSURLComponents alloc] initWithString:urlStr];
    __block NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [url.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setObject:obj.value forKey:obj.name];
    }];
   NSLog(@"====>zhifubao:%@",dic);
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *urlStr=@"http://baidu.com?alipay_root_cert_sn=687b59193f3f462dd5336e5abf83c5d8_02941eef3187dddf3d3b83462e1dfcf6&alipay_sdk=alipay-sdk-php-2020-04-15&app_cert_sn=5a6d29c893ebbe94778081c14cccc8a2&app_id=2021002117619942&biz_content=%7B%22body%22%3A%22%5Cu8d2d%5Cu4e70%5Cu53ef%5Cu53ef%5Cu5b9d%5Cu8d1dVIP%5Cu4f1a%5Cu5458%22%2C%22subject%22%3A%22%5Cu8d2d%5Cu4e70%5Cu53ef%5Cu53ef%5Cu5b9d%5Cu8d1dVIP%5Cu4f1a%5Cu545812+%5Cu4e2a%5Cu6708%22%2C%22total_amount%22%3A298%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22out_trade_no%22%3A%222088011334402752202205171805575950205%22%7D&charset=utf-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fapp.kekebaby.com%2Fkeke%2Fbll%2Fpayment%2Faplipay%2Fnotify_url_baby.php&sign_type=RSA2&timestamp=2022-05-17+18%3A05%3A57&version=1.0&sign=uP6kY48A5a0ytENmTORO4iJEpNVuq9Jyoq26gMeUbCLf6zto9%2BWnEzMXc4z4kQJEGnnXotfJKVW%2BErk5R1Jni5udo%2FBY9PAd%2F991Psp0t8O8u0c%2BcKwlVQysB%2FSqIMI83OAmcmRBW8XDufy1o119KrvM%2Fc1S2wi8VZawK%2F7uw9WVaOpP98DqcHfwKW6tG0ANuUYz2aWD%2FtOrBcFKcqWP2uVOvbqTPJeW37OenVwvmO7LB39bJ26bqL%2FcOirEeOb6ogsmtrxI8ggH4G%2FkHmn6yaIFCiBz8eXh6xVwVezk5jHDxp%2BSFnSB6aGhW0JWZkthgAAZG26uOyGuGUMyB14kCg%3D%3D";
    [self testUrl:urlStr];
    urlStr=@"https://openapi.alipay.com/gateway.do?alipay_sdk=alipay-sdk-java-dynamicVersionNo&app_id=2021003160653140&biz_content=%7B%22body%22%3A%22flowus-1%E4%B8%AA%E6%9C%88%22%2C%22out_trade_no%22%3A%2222327115000000c04e79a4%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22subject%22%3A%221%E4%B8%AA%E6%9C%88%22%2C%22timeout_express%22%3A%221m%22%2C%22total_amount%22%3A%2225.0%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Fdev.allflow.cn%2Fapi%2Fcallback%2FaliPay&sign=aXrh%2FdYhbCmDxSzzIW7nTGXpDbBmG8XPyVmdvf7ztvzXPXvayYIGjvT4pdyCQ6Hbiq%2FU%2FNPK22B9NyrgCvDhnl0q6KwN0B9DkZXkYtw3XwhgFQ%2BDSNXTqY4vtDUTrx%2BMw1MVrXOChkO%2F0io8UwYWP07rogACT9MUG6dQ1v2sxMvP7m51AePWcQcryoDgrezrp7TGWL3eG0p1igUOrKF1kf55OYUi8NC4XeX3XQfoSyBLbLxHp48bVsRM4CTzmtWoFO8t%2BBl%2F0QdW0qCZwn6WTIKZi0KLdCW1D7YXPGZU0DNw%2BgAgPP1bXRq77ns%2FIocj3PZpwKzWwWQW05iuLLzsFQ%3D%3D&sign_type=RSA2&timestamp=2022-11-23+11%3A50%3A37&version=1.0";
    [self testUrl:urlStr];
  

    NSLog(@"=========>margin:%f",[UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom);
    
   // [self.contentView setBackgroundColor:UIColor.grayColor];
    self.additionalSafeAreaInsets=[UIApplication sharedApplication].keyWindow.safeAreaInsets;
    NSLog(@"=========>margin2:%f",self.view.safeAreaInsets.bottom);
    
    [[[RACSignal just:@"xxx"] flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        NSLog(@"=================>yes:%@",value);
        return [RACSignal just:value];
    }] subscribe];
    
//    [self setCanceledOnTouchOutside:NO];
//    self.contentView.backgroundColor=UIColor.clearColor;
    [self testThrott];

    NSLog(@"=======>输入法 app:%@  %lld", [[self textInputMode] primaryLanguage],(long long)[self isThirdPartyKeyboard]);
    
    [RACObserve(UIApplication.sharedApplication, textInputContextIdentifier) subscribeNext:^(id  _Nullable x) {
        NSLog(@"=======>输入法监听 app:%@  %lld", [[self textInputMode] primaryLanguage],(long long)[self isThirdPartyKeyboard]);
    }];
  

    
    
    
    NSLog(@"======>super:%@",self.view.superview);
    [self testvc];
//
//    UITextField *text=[[UITextField alloc] initWithFrame:CGRectMake(0, 101, 300, 100)];
//    text.placeholder=@"请输入";
//    text.text=@"1";
//    text.tag=1;
//    [self.view addSubview:text];
//
//    text.disabled=YES;
//
//    UITextField *text2=[[UITextField alloc] initWithFrame:CGRectMake(0, 201, 300, 100)];
//    text2.placeholder=@"请输入2";
//    text2.text=@"2";
//    text2.tag=2;
//    [self.view addSubview:text2];
//    text2.disabled=NO;
//
//    YYTextView *text3=[[YYTextView alloc] initWithFrame:CGRectMake(0, 302, 300, 100)];
//    text3.placeholderText=@"请输入3";
//    text3.text=@"3";
//    text3.tag=3;
//    text3.delegate=self;
//    [self.view addSubview:text3];
    
    UIButton *oepnbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 101, 300, 100)];
    [oepnbtn setTitle:@"打开设置" forState:UIControlStateNormal];
    [oepnbtn setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    oepnbtn.backgroundColor=UIColor.yellowColor;
    [self.view addSubview:oepnbtn];
    [oepnbtn whenTapped:^{
        [self showModal];
    }];
    [self showModal];
    
    
    NXItemMenuImpl *item=[[NXItemMenuImpl alloc] initWithBlock:^(__kindof NXItemMenuImpl * _Nonnull it) {
        it.title=@"xxx";
    }];
    NSLog(@"==========>result:%@",item.title);
//    [item also:^(__kindof NSObject * _Nonnull it) {
//        it.title=@"xxx";
//    }];

    
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

    [[[[[self observeViewWillAppear] mapReplace:RACUnit.defaultUnit] doError:^(NSError * _Nonnull error) {
        NSLog(@"==============>observeViewWillAppear  doError");
    }] doCompleted:^{
        NSLog(@"==============>observeViewWillAppear  doCompleted");
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"==============>observeViewWillAppear");
    }];
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
    
    
    //__block NXTestRAC *t=NXTestRAC.new;
//    [RACScheduler.scheduler afterDelay:5 schedule:^{
//        t=nil;
//    }];
    
//
//    NSObject *obj=  [NSObject.alloc initByBlock:^(NSObject  *_Nonnull it) {
//        NSLog(@"=========>initByBlock:%@",it.simpleDescription);
//    }];
//    NSLog(@"=========>initByBlock2:%@",obj.simpleDescription);
//

//    NXTestRAC *robj=  [NXTestRAC.alloc initByBlock:^(NSObject  *_Nonnull it) {
//        NSLog(@"=========>initByBlock:%@",it.simpleDescription);
//    }];
   
   // [self testFormat];
    [self testHttp];
    [self testBind];
    [self testBind2];
    @weakify(self)
//    [RACScheduler.mainThreadScheduler afterDelay:5 schedule:^{
//        @strongify(self)
//        [self testBind];
//    }];
    
//    
//    [[[RACSignal just:@""] takeUntil:self.untilUniqueSignalWithIdentifier(@"xxxx")] subscribeNext:^(id  _Nullable x) {
//        
//    }];
    [self testSwitch];
    [self testEnumrator];
    
    if(!_changeSubject){
        _changeSubject=[RACSubject subject];
    }
    [[_changeSubject bindLifecycle:self.untilUniqueOrDeallocSignalWithIdentifier(__FILE_LINE__)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"============>changeSubject:%@",x);
    }];
    
    [[_changeSubject bindLifecycle:self.untilUniqueOrDeallocSignalWithIdentifier(__FILE_LINE__)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"============>changeSubject2:%@",x);
    }];
    
    [_changeSubject  sendNext:@"xx"];
    [RACScheduler.mainThreadScheduler afterDelay:2 schedule:^{
        [_changeSubject  sendNext:@"222"];
    }];
    double start=NSDate.now.timeIntervalSince1970*1000;
    for(int i=0;i<10000;i++){
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(testSwitch) name:@"xxxx" object:nil];
    }
    double end=NSDate.now.timeIntervalSince1970*1000;
    NSLog(@"=========>NSNotificationCenter take1:%f",(end-start));
    
    NSNotificationCenter *defaultCenter=   NSNotificationCenter.defaultCenter;
    start=NSDate.now.timeIntervalSince1970*1000;
    for(int i=0;i<10000;i++){
        [NSNotificationCenter.defaultCenter removeObserver:self];
    }
    end=NSDate.now.timeIntervalSince1970*1000;
    NSLog(@"=========>NSNotificationCenter take2:%f",(end-start));
    
    [self test2];
    [self test2];
    
   
   
}

-(void)test2{
//    [[[[[RACSignal just:@""] map:^id _Nullable(id  _Nullable value) {
//        [NSThread sleepForTimeInterval:1];
//        return value;
//    }] timeoutOnlyDebug:0.5] doError:^(NSError * _Nonnull error) {
//        NSLog(@"================>timeoutOnlyDebug:error:%@",error);
//    }].subscribeOnSubThread subscribeNext:^(id  _Nullable x) {
//        NSLog(@"================>timeoutOnlyDebug:next:%@",x);
//    }];
    

    @try {
        //@throw [[NSException  alloc] initWithName:@"xx" reason:@"xx" userInfo:@{}];
        @throw [NSError errorWithDomain:@"XXX" code:@"XX" userInfo:nil];
    } @catch (NSObject *exception) {
        NSError *error=[NSError nx_ErrorWithErrorOrException:exception];
        NSLog(@"============>catch了:%@",error);
    } @finally {
        NSLog(@"============>catch final了");
    }
    
    @try {
        @throw [[NSException  alloc] initWithName:@"xx" reason:@"xx" userInfo:@{}];
    } @catch (NSObject *exception) {
        NSException *ex=(NSException *)exception;
        
        double start=NSDate.now.timeIntervalSince1970*1000;
        for(int i=0;i<1000;i++){
            id a=ex.callStackSymbols;
            id b=ex.callStackReturnAddresses;
        }
        double end=NSDate.now.timeIntervalSince1970*1000;
        NSLog(@"============>callStack 耗时:%f",(end-start));
        
        NSError *error=[NSError nx_ErrorWithErrorOrException:exception];
        NSLog(@"============>catch2了:%@",error);
    } @finally {
        NSLog(@"============>catch2 final了");
    }
    
    NSLog(@"===========>init NXTestRAC");
    [[[[RACSignal interval:1 onScheduler:RACScheduler.scheduler]
       bindLifecycle:self.untilUniqueSignalWithIdentifier(__FILE_LINE__)]
     //  bindLifecycle:[self.untilDeallocSignal takeUntil:self.untilUniqueSignalWithIdentifier(__FILE_LINE__)]]
      doCompleted:^{
        NSLog(@"===========>rac next:%@",@"Completed");
    }] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"===========>rac next:%@",x);
    }];
    
    self.robj=  [NXTestRAC.alloc init];
    NSLog(@"=========>initByBlock2:%@",self.robj.simpleDescription);
    @weakify(self)
    [RACScheduler.scheduler afterDelay:2 schedule:^{
        @strongify(self)
        self.robj=nil;
    }];

}


-(void)testFormat{

//    NSDate *date=NSDate.now;
//    double start=NSDate.now.timeIntervalSince1970*1000;
//    NSString *str1=@"";
//    for(int i=0;i<10000;i++){
//        str1= [date stringWithFormat:@"YYYY-MM-dd HH:mm"];
//    }
//    double end=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"=========>stringWithFormat normal take:%f %@",(end-start),str1);
//
//
//    start=NSDate.now.timeIntervalSince1970*1000;
//    NSString *str2=@"";
//    for(int i=0;i<10000;i++){
//        str2=[date fastStringWithFormat:@"YYYY-MM-dd HH:mm"];
//    }
//    end=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"=========>stringWithFormat cache take:%f %@",(end-start),str2);
    
}

-(void)testHttp{
     NXParent *test=NXParent.new;
    test.success=YES;
    NSString *jsonStr=[test yy_modelToJSONString];
    NSLog(@"===============>testJson %@",jsonStr);
    NSDictionary *json=[test yy_modelToJSONObject];
    
    id successField=[json objectForKey:@"success"];
    NSNumber *number=[NSNumber nx_fromJSON:successField];
    NSLog(@"===============>testJson deser1== %@",number);
    
    NSNumber *number2=[NSNumber nx_fromJSON:@"true"];
    NSLog(@"===============>testJson deser2== %@",number2);
    
    NSNumber *number3=[NSNumber nx_fromJSON:@"false"];
    NSLog(@"===============>testJson deser3== %@",number3);
    
    NSNumber *number4=[NSNumber nx_fromJSON:@"YES"];
    NSLog(@"===============>testJson deser4== %@",number4);
    
    NSNumber *number5=[NSNumber nx_fromJSON:@"NO"];
    NSLog(@"===============>testJson deser5== %@",number5);
    
    NSNumber *number6=[NSNumber nx_fromJSON:@"1787643"];
    NSLog(@"===============>testJson deser6== %@",number6);
    
    
    
//    NSLog(@"===============>test1111 %@",test.simpleDescription);
//    [[RACSignal interval:1 onScheduler:RACScheduler.scheduler] subscribeNext:^(NSDate * _Nullable x) {
//        test.name=@"xxx";
//        NSLog(@"===============>test %@",test.simpleDescription);
//    }];
//    test=NXParent.new;
    
    
    NXHTTPSessionManager *manager=[NXHTTPSessionManager new];
    [[[manager GETSignal:@"http://api.map.baidu.com/telematics/v3/weather?location=%E5%98%89%E5%85%B4&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ" parameters:nil headers:nil progress:nil cacheType:NXNetCacheTypeFirstCache cacheTime:NXTimeUnit.DAYS.toMillis(1)] doError:^(NSError * _Nonnull error) {
        NSLog(@"============>x error:%@",error);
    }] subscribeNext:^(NXSessionDataTaskResult * _Nullable x) {
        NSLog(@"============>x:%@",x.responseObject);
    }];
}

-(void)testSwitch{

    NSString *startStr=@"2023/02/04";

    NSDate *startDate = [NSDate fastDateFromString:startStr withFormat:startStr.length > 10 ? @"yyyy/MM/dd HH:mm" : @"yyyy/MM/dd"];
    NSString *startDateFormat = [startDate fastStringWithFormat:@"yyyy/MM/dd"];
    NSString *nowStr = [NSDate.now fastStringWithFormat:@"yyyy/MM/dd"];

    NSString *constStr=@"4776467457667546754`";
    double start=NSDate.now.timeIntervalSince1970*1000;
    NSString *str1=@"";
    for(int i=0;i<1000;i++){
        str1=[NSString stringWithFormat:@"%@%@%@",str1,@",",constStr];
    }
    double end=NSDate.now.timeIntervalSince1970*1000;
    NSLog(@"=========>strApped by format take:%f",(end-start));
    
    
    start=NSDate.now.timeIntervalSince1970*1000;
    NSString *str2=@"";
    for(int i=0;i<1000;i++){
        str2=[str2 stringByAppendingFormat:@"%@%@",@",",constStr];
    }
    end=NSDate.now.timeIntervalSince1970*1000;
    NSLog(@"=========>strApped by appendingFormat take:%f",(end-start));
    
    
    start=NSDate.now.timeIntervalSince1970*1000;
    NSString *str3=@"";
    for(int i=0;i<1000;i++){
        str3=[str3 stringByAppendingString:@","];
        str3=[str3 stringByAppendingString:constStr];
    }
    end=NSDate.now.timeIntervalSince1970*1000;
    NSLog(@"=========>strApped by appending take:%f",(end-start));
    
    
    
    
    NSArray<NSNumber *> *arr=@[[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3]];
    NSString *str= [arr componentsJoinedByString:@"_" objectMapBlock:^NSString * _Nonnull(NSNumber * _Nonnull value) {
        return value.stringValue;
    }];
    NSLog(@"=========>componentsJoinedByString:%@",str);
}

-(void)testEnumrator{
    [RACScheduler.scheduler schedule:^{
        NSMutableArray<NSString *> *arry=[NSMutableArray array];
        for(int i=0;i<10000;i++){
            [arry addObject:[NSNumber numberWithInt:i].stringValue];
        }
        
        double start=NSDate.now.timeIntervalSince1970*1000;
        __block int i=0;
        [arry enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            i=30/5;
            i=i*i/2+i*8/6+4;
            [NSThread sleepForTimeInterval:0.001];
        }];
        double end=NSDate.now.timeIntervalSince1970*1000;
        NSLog(@"==========>enumerate normal take:%f",(end-start));

        
        start=NSDate.now.timeIntervalSince1970*1000;
   
        [arry enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             i=30/5;
             i=i*i/2+i*8/6+4;
            [NSThread sleepForTimeInterval:0.001];
        }];
        end=NSDate.now.timeIntervalSince1970*1000;
        NSLog(@"==========>enumerate by NSEnumerationConcurrent:%f",(end-start));
    }];
   
}

-(void)testBind{
    
//    NSString *testStr=@",校长,43,5,6,学生,";
//    double start=NSDate.now.timeIntervalSince1970*1000;
//    for(int i=0;i<10000;i++){
//        [testStr componentsSeparatedByString:@","].firstObject;
//    }
//    double end=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"==========>component take1:%f",(end-start));
//
//
//    start=NSDate.now.timeIntervalSince1970*1000;
//    for(int i=0;i<10000;i++){
//        [testStr componentsSeparatedByString:@","].lastObject;
//    }
//    end=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"==========>component take2:%f",(end-start));
//
//
//    start=NSDate.now.timeIntervalSince1970*1000;
//    for(int i=0;i<10000;i++){
//        [testStr firstComponentSeparatedByString:@","];
//    }
//    end=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"==========>component take3:%f",(end-start));
//
//
//    start=NSDate.now.timeIntervalSince1970*1000;
//    for(int i=0;i<10000;i++){
//        [testStr lastComponentSeparatedByString:@","];
//    }
//    end=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"==========>component take4:%f",(end-start));
//
//
//    testStr=@",校长,43,5,6,学生,";
//    NSLog(@"==========>componentSeparatedByString:%@",[testStr componentsSeparatedByString:@"."].firstObject);
//    NSLog(@"==========>componentSeparatedByString:%@",[testStr componentsSeparatedByString:@"."].lastObject);
//    NSLog(@"==========>componentSeparatedByString:%@",[testStr firstComponentSeparatedByString:@"."]);
//    NSLog(@"==========>componentSeparatedByString:%@",[testStr lastComponentSeparatedByString:@"."]);

    
//    NSString *identifier= [NSString stringWithFormat:@"%s_%d",__FILE__, __LINE__];
//    [[[[[RACObserve(self.view, frame)  flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        return [RACSignal just:@"xx"];
//    }].subscribeOnSubThread.deliverOnMainThread takeUntil:self.untilUniqueSignalWithIdentifier(identifier)] initially:^{
//        NSLog(@"==========>testBind start binding");
//    }] doCompleted:^{
//        NSLog(@"==========>testBind completed");
//    }] subscribeNext:^(id  _Nullable x) {
//       // NSLog(@"==========>testBind next");
//    }];
}

-(void)testBind2{
    NSString *identifier=__FILE_LINE__;     NSString *identifier2=__FILE_LINE__;
    double start=NSDate.now.timeIntervalSince1970*1000;
    for(int i=0;i<10000;i++){
        NSString *identifier= [NSString stringWithFormat:@"%s_%d",__FILE__, __LINE__];
    }
    double end=NSDate.now.timeIntervalSince1970*1000;
    NSLog(@"===========>file:%f",(end-start));
   
//    [[[[[RACObserve(self.view, frame)  flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
//        return [RACSignal just:@"xx"];
//    }].subscribeOnSubThread.deliverOnMainThread takeUntil:self.untilUniqueSignalWithIdentifier(__FILE_LINE__)] initially:^{
//        NSLog(@"==========>testBind start binding");
//    }] doCompleted:^{
//        NSLog(@"==========>testBind completed");
//    }] subscribeNext:^(id  _Nullable x) {
//       // NSLog(@"==========>testBind next");
//    }];
}

+ (CGRect)getFrameRelateWindowWithView:(UIView *)view {
    return [view convertRect:view.frame toView:nil];
}


-(void)showModal{
    UIPageViewController *s;
    
    [self.view endEditing:YES];
    UIViewController *popoverContent=[XXFHelperViewController new];
    popoverContent.modalPresentationConfig=[[[Presentr alloc] initWithPresentationType:PresentationType.alert] applyWithBlock:^(Presentr  *_Nonnull it) {
        it.dismissOnSwipe=YES;
        it.roundCorners=YES;
        it.cornerRadius=KRealWidth(8);
    }];
    [self presentViewController:popoverContent animated:YES completion:nil];

    
    
//    popoverContent.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    popoverContent.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:popoverContent animated:YES completion:nil];
//    [self presentViewController:popoverContent animated:YES completion:nil];
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
