//
//  NSMutableSet+NXUtil.m
//  NX
//
//  Created by hedeyong on 2021/06/20.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import "NSSet+NXUtil.h"

@implementation NSSet (NXUtil)

+ (BOOL)isEmpty:(NSSet *)object;
{
    BOOL result = YES;
    if (object != nil && [object isKindOfClass:[NSSet class]] && [object count] > 0) {
        result = NO;
    }
    return result;
}

- (BOOL)isEmpty
{
    return ([self count] == 0);
}

@end


@implementation NSMutableSet (NXUtil)

- (void)addObjects:(id)objects, ...
{
    if (objects == nil)
        return;
    
    [self addObjectCheck:objects];
    
    id next;
    va_list list;
    
    va_start(list, objects);
    while ((next = va_arg(list, id)) != nil) {
        [self addObjectCheck:next];
    }
    va_end(list);
}

- (void)addObjectCheck:(id)anObject
{
    if (anObject == nil) {
        NSLog(@"NSMutableSet addObject: anObject 为 nil");
        return;
    }
    [self addObject:anObject];
}

- (void)addChar:(char)value
{
    [self addObjectCheck:[NSNumber numberWithChar:value]];
}

- (void)addUnsignedChar:(unsigned char)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedChar:value]];
}

- (void)addShort:(short)value
{
    [self addObjectCheck:[NSNumber numberWithShort:value]];
}

- (void)addUnsignedShort:(unsigned short)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedShort:value]];
}

- (void)addInt:(int)value
{
    [self addObjectCheck:[NSNumber numberWithInt:value]];
}

- (void)addUnsignedInt:(unsigned int)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedInt:value]];
}

- (void)addLong:(long)value
{
    [self addObjectCheck:[NSNumber numberWithLong:value]];
}

- (void)addUnsignedLong:(unsigned long)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedLong:value]];
}

- (void)addLongLong:(long long)value
{
    [self addObjectCheck:[NSNumber numberWithLongLong:value]];
}

- (void)addUnsignedLongLong:(unsigned long long)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedLongLong:value]];
}

- (void)addFloat:(float)value
{
    [self addObjectCheck:[NSNumber numberWithFloat:value]];
}

- (void)addDouble:(double)value
{
    [self addObjectCheck:[NSNumber numberWithDouble:value]];
}

- (void)addBool:(BOOL)value
{
    [self addObjectCheck:[NSNumber numberWithBool:value]];
}

- (void)addInteger:(NSInteger)value
{
    [self addObjectCheck:[NSNumber numberWithInteger:value]];
}

- (void)addUnsignedInteger:(NSUInteger)value
{
    [self addObjectCheck:[NSNumber numberWithUnsignedInteger:value]];
}

- (void)addPointValue:(CGPoint)value
{
    [self addObjectCheck:[NSValue valueWithCGPoint:value]];
}

- (void)addSizeValue:(CGSize)value
{
    [self addObjectCheck:[NSValue valueWithCGSize:value]];
}

- (void)addRectValue:(CGRect)value
{
    [self addObjectCheck:[NSValue valueWithCGRect:value]];
}

@end
