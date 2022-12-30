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
   
    NSArray *array=[NSMutableArray arrayWithObjects:@"张三",@"张三",nil];
    NSLog(@"===========>array:%@",array.simpleDescription);
    NSMutableArray *array2=array.mutableCopy;
    NSLog(@"===========>array2:%@",array2.simpleDescription);
    
    
    NSString *str=@"a";
    NSLog(@"========>malloc_size = %zd", malloc_size((__bridge const void *)(str)));
    long s=1UL << 1;
    NSLog(@"============>%ld",s);
    
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
    
    
    [XXF initWithConfig:^CGFloat(CGFloat value) {
        return value;
    } appGroupNameProvider:^NSString * _Nonnull{
        return @"";
    } userIdProvider:^NSString * _Nonnull{
        return @"testUser";
    }];
    
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
