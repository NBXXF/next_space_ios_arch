//
//  NXRouter+NewInstance.m
//  AppArch
//
//  Created by XXF on 2022/9/28.
//

#import "NXRouter+NewInstance.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation NXRouter(NewInstance)
+ (UIViewController *)viewControllerWithRouteURL:(NSString *)routeURL parameters:(NSDictionary * _Nullable )parameters{
    id instance=NXRouter.getInstanceFactory(routeURL,parameters);
    if([instance isKindOfClass:UIViewController.class]){
        return (UIViewController *)instance;
    }
    return nil;
}


+ (void)startURL:(NSString *)url{
    [self startURL:url parameters:[NSMutableDictionary dictionary]];
}


+ (void)startURL:(NSString *)url parameters:(NSDictionary *)parameters{
    [self startURL:url parameters:parameters resultCallback:nil];
}


+ (void)startURL:(NSString *)url parameters:(NSDictionary *)parameters resultCallback:(NXRouterResultCallback)callback{
    if(NSThread.isMainThread){
        [NXRouter openURL:url parameters:parameters resultCallback:callback];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [NXRouter openURL:url parameters:parameters resultCallback:callback];
        });
    }
}
@end
