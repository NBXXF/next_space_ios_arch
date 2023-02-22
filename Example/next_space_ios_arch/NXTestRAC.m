//
//  NXTestRAC.m
//  next_space_ios_arch_Example
//
//  Created by XXF on 2023/2/14.
//  Copyright © 2023 Wenjinfu. All rights reserved.
//

#import "NXTestRAC.h"
#import <next_space_ios_arch/next_space_ios_arch-umbrella.h>

@implementation NXTestRAC

- (instancetype)init{
    self=[super init];
    if(self){
        NSLog(@"===========>init NXTestRAC");
        [[[[RACSignal interval:1 onScheduler:RACScheduler.scheduler]
           bindLifecycle:self.untilUniqueOrDeallocSignalWithIdentifier(__FILE_LINE__)]
         //  bindLifecycle:[self.untilDeallocSignal takeUntil:self.untilUniqueSignalWithIdentifier(__FILE_LINE__)]]
          doCompleted:^{
            NSLog(@"===========>rac next:%@",@"Completed");
        }] subscribeNext:^(NSDate * _Nullable x) {
            NSLog(@"===========>rac next:%@",x);
        }];
    }
    return self;
}
//
//+ (void)initialize{
//    NSLog(@"===========>initialize NXTestRAC");
//}


@end
