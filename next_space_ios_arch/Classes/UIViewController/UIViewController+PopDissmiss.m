//
//  UIViewController+ShowDissmiss.m
//  next_space_ios_arch
//  Created by XXF on 2022/10/19.
//

#import "UIViewController+PopDissmiss.h"

@implementation UIViewController(PopDissmiss)

- (void)backViewControllerAnimated:(BOOL)anim completion:(void (^)(void))completion{
    if (self.navigationController==nil || [self.navigationController.viewControllers.firstObject isEqual:self]){
        //当前页面尚未被Push过
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        if(completion){
            completion();
        }
    }
}
- (void)popOrDismissViewControllerAnimated:(BOOL)anim completion:(void (^)(void))completion{
    [self backViewControllerAnimated:anim completion:completion];
}

- (void)finishNavigationControllerAnimated:(BOOL)anim completion:(void (^)(void))completion{
    UIViewController *navigationController= self.navigationController;
    if(!navigationController){
        [self dismissViewControllerAnimated:anim completion:completion];
    }else{
        [navigationController dismissViewControllerAnimated:anim completion:completion];
    }
}
@end
