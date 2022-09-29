//
//  NXRouter+NewInstance.m
//  AppArch
//
//  Created by XXF on 2022/9/28.
//

#import "NXRouter+NewInstance.h"

@implementation NXRouter(NewInstance)
+ (UIViewController *)viewControllerWithRouteURL:(NSString *)routeURL parameters:(NSDictionary * _Nullable )parameters{
    id instance=NXRouter.getInstanceFactory(routeURL,parameters);
    if([instance isKindOfClass:UIViewController.class]){
        return (UIViewController *)instance;
    }
    return nil;
}
@end
