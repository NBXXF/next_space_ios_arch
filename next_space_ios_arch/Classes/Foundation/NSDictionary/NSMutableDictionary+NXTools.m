//
//  NSMutableDictionary+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import "NSMutableDictionary+NXTools.h"

@implementation NSMutableDictionary(NXTools)
- (NSMutableDictionary *)applyWithBlock:(NSMutableDictionary * _Nonnull (^)(NSMutableDictionary * _Nonnull))block{
    return block(self);
}
@end
