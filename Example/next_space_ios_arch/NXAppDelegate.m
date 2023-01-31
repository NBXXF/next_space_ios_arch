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
#import <malloc/malloc.h>

@implementation NXAppDelegate

- (BOOL)onKeyCommand:(UIKeyCommand *)command commandEvent:(NSString *)event originatingResponder:(UIResponder *)originatingResponder{
    NSLog(@"===========>执行key %@ by %@",command.input,self.simpleDescription);
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
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
    }];
    [XXF startPerformanceMonitor:10.5];
    
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
    
    //[NSThread sleepForTimeInterval:1.0];
    
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
