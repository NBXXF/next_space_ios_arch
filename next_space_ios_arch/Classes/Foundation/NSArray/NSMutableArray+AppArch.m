//
//  NSMutableArray+AppArch.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/11/26.
//

#import "NSMutableArray+AppArch.h"

@implementation NSMutableArray(AppArch)

- (__kindof NSMutableArray *)applyWithBlock:(void (^)(__kindof NSMutableArray * _Nonnull))block{
    block(self);
    return self;
}
@end
