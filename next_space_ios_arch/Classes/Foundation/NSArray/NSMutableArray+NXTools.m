//
//  NSMutableArray+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import "NSMutableArray+NXTools.h"

@implementation NSMutableArray(NXTools)

- (NSMutableArray *)applyWithBlock:(void (^)(NSMutableArray * _Nonnull))block{
    block(self);
    return self;
}
@end
