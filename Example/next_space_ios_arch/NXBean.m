//
//  NXBean.m
//  next_space_ios_arch_Example
//
//  Created by 1234 on 2022/11/28.
//  Copyright © 2022 Wenjinfu. All rights reserved.
//

#import "NXBean.h"
#import <YYModel/YYModel.h>

@implementation NXBean
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { return [self yy_modelInitWithCoder:aDecoder]; }
@end
