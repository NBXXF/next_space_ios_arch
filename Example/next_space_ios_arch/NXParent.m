//
//  NXParent.m
//  next_space_ios_arch_Example
//
//  Created by 1234 on 2023/2/21.
//  Copyright © 2023 Wenjinfu. All rights reserved.
//

#import "NXParent.h"

@implementation NXParent

+ (void)initialize{
    NSLog(@"===========>initialize NXParent");
}
- (instancetype)init{
    self=[super init];
    if(self){
        NSLog(@"===========>init NXParent");
    }
    return self;
}
@end
