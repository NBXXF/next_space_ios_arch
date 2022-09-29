//
//  NXRouter+NewInstance.h
//  AppArch
//
//  Created by XXF on 2022/9/28.
//

#import <Foundation/Foundation.h>
#import "NXRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface NXRouter(NewInstance)
+ (UIViewController * __nullable)viewControllerWithRouteURL:(NSString *)routeURL parameters:(NSDictionary * _Nullable )parameters;
@end

NS_ASSUME_NONNULL_END
