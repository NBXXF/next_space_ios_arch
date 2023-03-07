//
//  NSMutableDictionary+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/12/29.
//

#import "NSMutableDictionary+NXTools.h"

@implementation NSMutableDictionary(NXTools)

- (instancetype)applyWithBlock:(void (^)(NSMutableDictionary * _Nonnull))block{
    block(self);
    return self;
}


- (void)put:(id<NSCopying>)aKey forObject:(id)anObject{
    [self setObject:anObject forKey:aKey];
}



- (BOOL)putCheck:(id<NSCopying>)aKey forObject:(id)anObject{
    if (aKey == nil) {
        return NO;
    }
    if (anObject == nil) {
        return NO;
    }
    [self put:aKey forObject:anObject];
    return YES;
}

@end
