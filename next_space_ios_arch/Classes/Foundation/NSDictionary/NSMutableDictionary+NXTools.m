//
//  NSMutableDictionary+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import "NSMutableDictionary+NXTools.h"

@implementation NSMutableDictionary(NXTools)

- (NSMutableDictionary *)applyWithBlock:(void (^)(NSMutableDictionary * _Nonnull))block{
    block(self);
    return self;
}

@end
