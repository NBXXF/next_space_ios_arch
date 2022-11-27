//
//  UIViewController+Lifecycle.m
//  next_space_ios_arch
//  生命周期
//  Created by XXF on 2022/10/12.
//

#import "UIViewController+Lifecycle.h"

@implementation UIViewController(Lifecycle)

- (RACSignal *)observeViewDidLoad{
    return [self rac_signalForSelector:@selector(viewDidLoad)];
}

- (RACSignal *)observeViewWillAppear{
    return [self rac_signalForSelector:@selector(viewWillAppear:)];
}

- (RACSignal *)observeViewDidAppear{
    return [self rac_signalForSelector:@selector(viewDidAppear:)];
}

- (RACSignal *)observeViewWillDisappear{
    return [self rac_signalForSelector:@selector(viewWillDisappear:)];
}

- (RACSignal *)observeViewDidDisappear{
    return [self rac_signalForSelector:@selector(viewDidDisappear:)];
}
@end
