//
//  NXAppDelegate.m
//  next_space_ios_arch
//
//  Created by Wenjinfu on 09/29/2022.
//  Copyright (c) 2022 Wenjinfu. All rights reserved.
//

#import "NXAppDelegate.h"
#import "NXDemoViewController.h"
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>
#import <next_space_ios_arch/UIScreen+NXTools.h>
#import <next_space_ios_arch/NSObject+NXTools.h>
#import <malloc/malloc.h>
#import  <YYText/YYText.h>

@implementation NXAppDelegate

- (BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event originatingResponder:(UIResponder *)originatingResponder{
    NSLog(@"===========>执行key %@ by %@",command.input,self.simpleDescription);
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *a=[NSString stringWithFormat:@"%@",@"x"];
    NSString *b=@"x";
    BOOL ab=a==b;
    BOOL ab1=[a isEqual:b];
    
  BOOL TT=  [NSURL isWEBURLWithString:@"ddd"];
  BOOL TT2=  [NSURL isWEBURLWithString:@"https://www.cnblogs.com/diweinan/p/6214044.html"];
   NSString *tstr0= @"http://www.baidu.com/import-dev/0cc22faf-5dbb-45f1-acd7-2f6dd481ab8a/%E5%AF%BC%E5%87%BAword+9ef316bb-f433-427d-adf9-d4e7c25f439a.docx";
   NSString *tstr1= [NSURL formatURLPathWithPath:tstr0 encoded:NO];
   NSString *tstr2=  [NSURL formatURLPathWithPath:tstr1 encoded:NO];
    
    
    NSURL *appendUrl=[NSURL URLWithString:@"user/xxxx"];
    NSURL *baseURL=[NSURL URLWithString:@"https://www.baidu.com/api/"];
    NSString *FULL= [NSURL URLWithString:appendUrl.absoluteString relativeToURL:baseURL].absoluteString;
    
    
    NSURL *appendUrl1=[NSURL URLWithString:@"user/xxxx"];
    NSURL *baseURL2=[NSURL URLWithString:@"https://www.baidu.com/api"];
    NSString *FULL2= [NSURL URLWithString:appendUrl.absoluteString relativeToURL:baseURL].absoluteString;
    
    NSDate *date=NSDate.now;
    [date dayOfYear];
    
    long long yearMillis=NXTimeUnit.DAYS.toMillis(365);
    long long desiredExpireTime=1770699523192;
    long long year=(desiredExpireTime-NSDate.now.timeIntervalSince1970*1000)/yearMillis;
    long long day=NXTimeUnit.MILLISECONDS.toDays((desiredExpireTime-NSDate.now.timeIntervalSince1970*1000)-year*yearMillis);
    
//    NSString *str1=@"xxx";
//    YYThreadSafeArray *safeArray=[YYThreadSafeArray array];
//    double start1=NSDate.now.timeIntervalSince1970*1000;
//    for(int i=0;i<10000;i++){
//        [safeArray addObject:str1];
//    }
//    double end1=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"==========>array take1:%f",(end1-start1));
//    
//    NSMutableArray *array1=[NSMutableArray array];
//    start1=NSDate.now.timeIntervalSince1970*1000;
//    for(int i=0;i<10000;i++){
//        [array1 addObject:str1];
//    }
//    end1=NSDate.now.timeIntervalSince1970*1000;
//    NSLog(@"==========>array take2:%f",(end1-start1));
//    
//    
    
    
    
   

    
    
    
    
    
    long long m=NXTimeUnit.DAYS.toMillis(1);
    NSLog(@"========>m:%lld",m);
    
    long long m2=NXTimeUnit.DAYS.toDays(2);
    NSLog(@"========>m2:%lld",m2);
    
    long long m3=NXTimeUnit.MILLISECONDS.toDays(86400000);
    NSLog(@"========>m3:%lld",m3);
    
    NSString *s1=@"";
    NSDictionary *dict=[application applyWithBlock:^(UIApplication *_Nonnull it) {
        
    }];
    NSMutableArray<NSString *> *temp=NSMutableArray.array;
//    [temp applyWithBlock:^(NSMutableArray<NSString *> * _Nonnull it) {
//        return nil;
//    }];
    
    NSMutableArray<NSString *> *arr=NSMutableArray.array;
    for(int i=0;i<100;i++){
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    CGFloat start=NSDate.date.timeIntervalSince1970*1000;
    for(int i=0;i<100;i++){
        [arr.rac_sequence filter:^BOOL(NSString *_Nullable value) {
            return [value isEqual:@"50"];
        }].array.firstObject;
    }
    CGFloat end=NSDate.date.timeIntervalSince1970*1000;
    NSLog(@"===========>take1:%f",(end-start));
    
    
    start=NSDate.date.timeIntervalSince1970*1000;
    for(int i=0;i<100;i++){
        [arr firstObjectWithBlock:^BOOL(NSString * _Nonnull value) {
            return [value isEqual:@"50"];
        }];
    }
    end=NSDate.date.timeIntervalSince1970*1000;
    NSLog(@"===========>take2:%f",(end-start));
    
    [[RACSignal fromCallbck:^id _Nullable{
            return @"xxx";
    }].deliverOnMainThread subscribeNext:^(id  _Nullable x) {
        NSLog(@"===========>yes:%@",x);
    }];
    
    [[RACSignal defer:^RACSignal * _Nonnull{
        NSLog(@"===========>thread1:%@",NSThread.currentThread);
        return [[RACSignal defer:^RACSignal * _Nonnull{
            NSLog(@"===========>thread2:%@",NSThread.currentThread);
            return [[RACSignal fromCallbck:^id _Nullable{
                NSLog(@"===========>thread3:%@",NSThread.currentThread);
                return @"";
            }] subscribeOnSubThread:YES];
        }] subscribeOnSubThread:YES];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"===========>thread3:%@",NSThread.currentThread);
    }];
//    [[[RACSignal interval:1 onScheduler:RACScheduler.scheduler] distinctUntilChangedWithBlock:^BOOL(NSDate * _Nonnull last, NSDate * _Nonnull current) {
//            return [last isEqual:current];
//    }] subscribeNext:^(NSDate * _Nullable x) {
//        NSLog(@"===========>distinct1:%@",x);
//    }];
    
    [[[[RACSignal just:@"1"] concat:[RACSignal just:@"1"]] distinctUntilChangedWithBlock:^BOOL(id  _Nonnull last, id  _Nonnull current) {
           // return [last isEqual:current];
        return false;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"===========>distinct2:%@",x);
    }];
    NSString *s= [NSString toKindOfClassObjectOrNilFrom:nil];
    NSArray *array=[NSMutableArray arrayWithObjects:@"张三",@"张三",nil];
    [array.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return @"";
    }];
    NSLog(@"===========>array:%@",array.simpleDescription);
    NSMutableArray *array2=array.mutableCopy;
    NSLog(@"===========>array2:%@",array2.simpleDescription);
    
    
    NSString *str=@"a";
    NSLog(@"========>malloc_size = %zd", malloc_size((__bridge const void *)(str)));

    
    NSLog(@"============>scale:%f", UIScreen.mainScreen.scale);
    NSLog(@"============>scale width:%f",  [UIScreen mainScreen].bounds.size.width);
    NSLog(@"============>scale width:%f",  [UIScreen.mainScreen getDensityValue:14]);
    
    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSLog(@"=============>delay next2:2");
                [subscriber sendNext:@"2"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }] delay:1] doNext:^(id  _Nullable x) {
        NSLog(@"=============>delay next donnext2:%@",x);
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"=============>delay next sub:2:%@",x);
    }];
    
//    [[[RACSignal fromCallbck:^id _Nullable{
//        NSLog(@"=============>delay start next:1");
//        return @"1";
//    }] delay:1] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"=============>delay next:%@",x);
//    }];
    
    [XXF initWithConfig:^NSString * _Nonnull{
        return @"";
    } userIdProvider:^NSString * _Nonnull{
        return @"testUser";
    } configOption:[XXFConfigOption.new applyWithBlock:^(XXFConfigOption *_Nonnull it) {
        it.allowCallStackSymbols=YES;
    }]];
    
   
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in windows) {
        if(window.rootViewController == nil){
            UIViewController *vc = [[UINavigationController alloc] initWithRootViewController:[NXDemoViewController new]];
            window.rootViewController = vc;
        }
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // self.window.rootViewController=[NXViewController new];
    // Override point for customization after application launch.
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    UIPasteboard *pasteboard =[UIPasteboard generalPasteboard];
    pasteboard.persistent=YES;
    [NXPasteboard copyToApplication:pasteboard];
    
    [RACScheduler afterDelayInMainThreadScheduler:0.1 schedule:^{
        NSLog(@"===============>str1:%s",[NXPasteboard getFromApplication].string);
    }];
    [RACScheduler afterDelayInMainThreadScheduler:0.4 schedule:^{
        NSLog(@"===============>str2:%s",[NXPasteboard getFromApplication].string);
    }];
    [RACScheduler afterDelayInMainThreadScheduler:0.8 schedule:^{
        NSLog(@"===============>str3:%s",[NXPasteboard getFromApplication].string);
    }];
    [RACScheduler afterDelayInMainThreadScheduler:1.0 schedule:^{
        NSLog(@"===============>str4:%s",[NXPasteboard getFromApplication].string);
    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
