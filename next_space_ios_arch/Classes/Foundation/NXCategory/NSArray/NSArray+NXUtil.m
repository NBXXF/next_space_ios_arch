//
//  NSArray+NXUtil.m
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import "NSArray+NXUtil.h"
#import "NSString+NXUtil.h"

@implementation NSArray (NXUtil)

+ (BOOL)nx_isEmpty:(NSArray *)object;
{
    BOOL result = YES;
    if (object != nil && [object isKindOfClass:[NSArray class]] && [object count] > 0) {
        result = NO;
    }
    return result;
}

- (id)nx_anyObject
{
    return [self count] > 0 ? [self nx_objectAtIndexCheck:0] : nil;
}

- (NSArray *)nx_arrayWithItemsOfClass:(__unsafe_unretained Class)aClass
{
    if (!aClass) {
        return self;
    }

    NSMutableArray *container = [NSMutableArray array];

    for (id item in self) {
        if ([item isKindOfClass:aClass]) {
            [container addObject:item];
        }
    }

    return [container copy];
}

- (NSArray *)nx_arrayWithItemsOfProtocol:(Protocol *)aProtocol
{
    if (!aProtocol) {
        return self;
    }
    
    NSMutableArray *container = [NSMutableArray array];
    
    for (id item in self) {
        if ([item conformsToProtocol:aProtocol]) {
            [container addObject:item];
        }
    }
    
    return [container copy];
}
- (id)nx_objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)nx_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass
{
    return [self nx_objectAtIndexCheck:index class:aClass defaultValue:nil];
}

- (id)nx_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if (![value isKindOfClass:aClass]) {
        return defaultValue;
    }
    return value;
}

- (NSArray *)nx_arrayAtIndex:(NSUInteger)index
{
    return [self nx_arrayAtIndex:index defaultValue:nil];
}

- (NSArray *)nx_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return [self nx_objectAtIndexCheck:index class:[NSArray class] defaultValue:defaultValue];
}

- (NSMutableArray *)nx_mutableArrayAtIndex:(NSUInteger)index
{
    return [self nx_mutableArrayAtIndex:index defaultValue:nil];
}

- (NSMutableArray *)nx_mutableArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return [self nx_objectAtIndexCheck:index class:[NSMutableArray class] defaultValue:defaultValue];
}

- (NSDictionary *)nx_dictionaryAtIndex:(NSUInteger)index
{
    return [self nx_dictionaryAtIndex:index defaultValue:nil];
}

- (NSDictionary *)nx_dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue
{
    return [self nx_objectAtIndexCheck:index class:[NSDictionary class] defaultValue:defaultValue];
}

- (NSMutableDictionary *)nx_mutableDictionaryAtIndex:(NSUInteger)index
{
    return [self nx_mutableDictionaryAtIndex:index defaultValue:nil];
}

- (NSMutableDictionary *)nx_mutableDictionaryAtIndex:(NSUInteger)index defaultValue:(NSMutableDictionary *)defaultValue
{
    return [self nx_objectAtIndexCheck:index class:[NSMutableDictionary class] defaultValue:defaultValue];
}

- (NSData *)nx_dataAtIndex:(NSUInteger)index
{
    return [self nx_dataAtIndex:index defaultValue:nil];
}

- (NSData *)nx_dataAtIndex:(NSUInteger)index defaultValue:(NSData *)defaultValue
{
    return [self nx_objectAtIndexCheck:index class:[NSData class] defaultValue:defaultValue];
}

- (NSString *)nx_stringAtIndex:(NSUInteger)index
{
    return [self nx_stringAtIndex:index defaultValue:nil];
}

- (NSString *)nx_stringAtIndexToString:(NSUInteger)index
{
    return [self nx_stringAtIndex:index defaultValue:@""];
}

- (NSString *)nx_stringAtIndexToString:(NSUInteger)index defaultValue:(NSString *)defaultValue
{
    NSString *value = [self nx_stringAtIndex:index defaultValue:@""];
    if (!value || value.length == 0) {
        value = defaultValue;
    }
    return value;
}

- (NSString *)nx_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    if ([value isKindOfClass:[NSURL class]]) {
        return [value absoluteString];
    }
    
    if (![value isKindOfClass:[NSString class]]) {
        return defaultValue;
    }
    return value;
}

- (NSNumber *)nx_numberAtIndex:(NSUInteger)index
{
    return [self nx_numberAtIndex:index defaultValue:nil];
}

- (NSNumber *)nx_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]]) {
        return [value nx_numberValue];
    }
    
    if (![value isKindOfClass:[NSNumber class]]) {
        return defaultValue;
    }
    
    return value;
}

- (char)nx_charAtIndex:(NSUInteger)index
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value charValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value charValue];
    }
    else {
        return 0x0;
    }
}

- (unsigned char)nx_unsignedCharAtIndex:(NSUInteger)index
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedCharValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value unsignedCharValue];
    }
    else {
        return 0x0;
    }
}

- (short)nx_shortAtIndex:(NSUInteger)index
{
    return [self nx_shortAtIndex:index defaultValue:0];
}

- (short)nx_shortAtIndex:(NSUInteger)index defaultValue:(short)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shortValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned short)nx_unsignedShortAtIndex:(NSUInteger)index
{
    return [self nx_unsignedShortAtIndex:index defaultValue:0];
}

- (unsigned short)nx_unsignedShortAtIndex:(NSUInteger)index defaultValue:(unsigned short)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedShortValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value unsignedShortValue];
    }
    else {
        return defaultValue;
    }
}

- (int)nx_intAtIndex:(NSUInteger)index
{
    return [self nx_intAtIndex:index defaultValue:0];
}

- (int)nx_intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned int)nx_unsignedIntAtIndex:(NSUInteger)index
{
    return [self nx_unsignedIntAtIndex:index defaultValue:0];
}

- (unsigned int)nx_unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value unsignedIntValue];
    }
    else {
        return defaultValue;
    }
}

- (long)nx_longAtIndex:(NSUInteger)index
{
    return [self nx_longAtIndex:index defaultValue:0];
}

- (long)nx_longAtIndex:(NSUInteger)index defaultValue:(long)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value longValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value longValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long)nx_unsignedLongAtIndex:(NSUInteger)index
{
    return [self nx_unsignedLongAtIndex:index defaultValue:0];
}

- (unsigned long)nx_unsignedLongAtIndex:(NSUInteger)index defaultValue:(unsigned long)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value unsignedLongValue];
    }
    else {
        return defaultValue;
    }
}

- (long long)nx_longLongAtIndex:(NSUInteger)index
{
    return [self nx_longLongAtIndex:index defaultValue:0];
}

- (long long)nx_longLongAtIndex:(NSUInteger)index defaultValue:(long long)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long long)nx_unsignedLongLongAtIndex:(NSUInteger)index
{
    return [self nx_unsignedLongLongAtIndex:index defaultValue:0];
}

- (unsigned long long)nx_unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value unsignedLongLongValue];
    }
    else {
        return defaultValue;
    }
}

- (float)nx_floatAtIndex:(NSUInteger)index
{
    return [self nx_floatAtIndex:index defaultValue:0.0];
}

- (float)nx_floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        float result = [value floatValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (double)nx_doubleAtIndex:(NSUInteger)index
{
    return [self nx_doubleAtIndex:index defaultValue:0.0];
}

- (double)nx_doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        double result = [value doubleValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (BOOL)nx_boolAtIndex:(NSUInteger)index
{
    return [self nx_boolAtIndex:index defaultValue:NO];
}

- (BOOL)nx_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    else {
        return defaultValue;
    }
}

- (NSInteger)nx_integerAtIndex:(NSUInteger)index
{
    return [self nx_integerAtIndex:index defaultValue:0];
}

- (NSInteger)nx_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    else {
        return defaultValue;
    }
}

- (NSUInteger)nx_unsignedIntegerAtIndex:(NSUInteger)index
{
    return [self nx_unsignedIntegerAtIndex:index defaultValue:0];
}

- (NSUInteger)nx_unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value unsignedIntegerValue];
    }
    else {
        return defaultValue;
    }
}

- (CGPoint)nx_pointAtIndex:(NSUInteger)index
{
    return [self nx_pointAtIndex:index defaultValue:CGPointZero];
}

- (CGPoint)nx_pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]] && ![value isEmpty]) {
        return CGPointFromString(value);
    }
    else if ([value isKindOfClass:[NSValue class]]) {
        return [value CGPointValue];
    }
    else {
        return defaultValue;
    }
}

- (CGSize)nx_sizeAtIndex:(NSUInteger)index
{
    return [self nx_sizeAtIndex:index defaultValue:CGSizeZero];
}

- (CGSize)nx_sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]] && ![value isEmpty]) {
        return CGSizeFromString(value);
    }
    else if ([value isKindOfClass:[NSValue class]]) {
        return [value CGSizeValue];
    }
    else {
        return defaultValue;
    }
}

- (CGRect)nx_rectAtIndex:(NSUInteger)index
{
    return [self nx_rectAtIndex:index defaultValue:CGRectZero];
}

- (CGRect)nx_rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue
{
    id value = [self nx_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]] && ![value isEmpty]) {
        return CGRectFromString(value);
    }
    else if ([value isKindOfClass:[NSValue class]]) {
        return [value CGRectValue];
    }
    else {
        return defaultValue;
    }
}

@end

@implementation NSMutableArray (NXUtil)

- (void)nx_addObjectsFromArrayCheck:(NSArray *)otherArray {
    if ([NSArray nx_isEmpty:otherArray]) {
        return;
    }
    [self addObjectsFromArray:otherArray];
}

- (void)nx_addObjects:(id)objects, ...
{
    if (objects == nil)
        return;
    
    [self nx_addObjectCheck:objects];
    
    id next;
    va_list list;
    
    va_start(list, objects);
    while ((next = va_arg(list, id)) != nil) {
        [self nx_addObjectCheck:next];
    }
    va_end(list);
}

- (void)nx_addObjectCheck:(id)anObject
{
    if (anObject == nil) {
        //NSLog(@"NSArray addObject: anObject 为 nil");
        return;
    }
    [self addObject:anObject];
}

- (void)nx_addChar:(char)value
{
    [self nx_addObjectCheck:[NSNumber numberWithChar:value]];
}

- (void)nx_addUnsignedChar:(unsigned char)value
{
    [self nx_addObjectCheck:[NSNumber numberWithUnsignedChar:value]];
}

- (void)nx_addShort:(short)value
{
    [self nx_addObjectCheck:[NSNumber numberWithShort:value]];
}

- (void)nx_addUnsignedShort:(unsigned short)value
{
    [self nx_addObjectCheck:[NSNumber numberWithUnsignedShort:value]];
}

- (void)nx_addInt:(int)value
{
    [self nx_addObjectCheck:[NSNumber numberWithInt:value]];
}

- (void)nx_addUnsignedInt:(unsigned int)value
{
    [self nx_addObjectCheck:[NSNumber numberWithUnsignedInt:value]];
}

- (void)nx_addLong:(long)value
{
    [self nx_addObjectCheck:[NSNumber numberWithLong:value]];
}

- (void)nx_addUnsignedLong:(unsigned long)value
{
    [self nx_addObjectCheck:[NSNumber numberWithUnsignedLong:value]];
}

- (void)nx_addLongLong:(long long)value
{
    [self nx_addObjectCheck:[NSNumber numberWithLongLong:value]];
}

- (void)nx_addUnsignedLongLong:(unsigned long long)value
{
    [self nx_addObjectCheck:[NSNumber numberWithUnsignedLongLong:value]];
}

- (void)nx_addFloat:(float)value
{
    [self nx_addObjectCheck:[NSNumber numberWithFloat:value]];
}

- (void)nx_addDouble:(double)value
{
    [self nx_addObjectCheck:[NSNumber numberWithDouble:value]];
}

- (void)nx_addBool:(BOOL)value
{
    [self nx_addObjectCheck:[NSNumber numberWithBool:value]];
}

- (void)nx_addInteger:(NSInteger)value
{
    [self nx_addObjectCheck:[NSNumber numberWithInteger:value]];
}

- (void)nx_addUnsignedInteger:(NSUInteger)value
{
    [self nx_addObjectCheck:[NSNumber numberWithUnsignedInteger:value]];
}

- (void)nx_addPointValue:(CGPoint)value
{
    [self nx_addObjectCheck:[NSValue valueWithCGPoint:value]];
}

- (void)nx_addSizeValue:(CGSize)value
{
    [self nx_addObjectCheck:[NSValue valueWithCGSize:value]];
}

- (void)nx_addRectValue:(CGRect)value
{
    [self nx_addObjectCheck:[NSValue valueWithCGRect:value]];
}

- (void)nx_insertObjectCheck:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) {
        NSLog(@"insertObjectCheck:atIndex: anObject 为 nil");
        return;
    }
    if (index > [self count]) {
        NSLog(@"insertObjectCheck:atIndex: index 越界");
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)nx_insertChar:(char)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithChar:value] atIndex:index];
}

- (void)nx_insertUnsignedChar:(unsigned char)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithUnsignedChar:value] atIndex:index];
}

- (void)nx_insertShort:(short)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithShort:value] atIndex:index];
}

- (void)nx_insertUnsignedShort:(unsigned short)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithUnsignedShort:value] atIndex:index];
}

- (void)nx_insertInt:(int)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithInt:value] atIndex:index];
}

- (void)nx_insertUnsignedInt:(unsigned int)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithUnsignedInt:value] atIndex:index];
}

- (void)nx_insertLong:(long)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithLong:value] atIndex:index];
}

- (void)nx_insertUnsignedLong:(unsigned long)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithUnsignedLong:value] atIndex:index];
}

- (void)nx_insertLongLong:(long long)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithLongLong:value] atIndex:index];
}

- (void)nx_insertUnsignedLongLong:(unsigned long long)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithUnsignedLongLong:value] atIndex:index];
}

- (void)nx_insertFloat:(float)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithFloat:value] atIndex:index];
}

- (void)nx_insertDouble:(double)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithDouble:value] atIndex:index];
}

- (void)nx_insertBool:(BOOL)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithBool:value] atIndex:index];
}

- (void)nx_insertInteger:(NSInteger)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithInteger:value] atIndex:index];
}

- (void)nx_insertUnsignedInteger:(NSUInteger)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSNumber numberWithUnsignedInteger:value] atIndex:index];
}

- (void)nx_insertPointValue:(CGPoint)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSValue valueWithCGPoint:value] atIndex:index];
}

- (void)nx_insertSizeValue:(CGSize)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSValue valueWithCGSize:value] atIndex:index];
}

- (void)nx_insertRectValue:(CGRect)value atIndex:(NSUInteger)index
{
    [self nx_insertObjectCheck:[NSValue valueWithCGRect:value] atIndex:index];
}

- (void)nx_replaceObjectCheckAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject == nil) {
        NSLog(@"replaceObjectCheckAtIndex:withObject: anObject 为 nil");
        return;
    }
    
    if (index >= [self count]) {
        NSLog(@"replaceObjectCheckAtIndex:withObject: index 越界");
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)nx_replaceCharAtIndex:(NSUInteger)index withChar:(char)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithChar:value]];
}

- (void)nx_replaceUnsignedCharAtIndex:(NSUInteger)index withUnsignedChar:(unsigned char)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedChar:value]];
}

- (void)nx_replaceShortAtIndex:(NSUInteger)index withShort:(short)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithShort:value]];
}

- (void)nx_replaceUnsignedShortAtIndex:(NSUInteger)index withUnsignedShort:(unsigned short)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedShort:value]];
}

- (void)nx_replaceIntAtIndex:(NSUInteger)index withInt:(int)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithInt:value]];
}

- (void)nx_replaceUnsignedIntAtIndex:(NSUInteger)index withUnsignedInt:(unsigned int)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedInt:value]];
}

- (void)nx_replaceLongAtIndex:(NSUInteger)index withLong:(long)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithLong:value]];
}

- (void)nx_replaceUnsignedLongAtIndex:(NSUInteger)index withUnsignedLong:(unsigned long)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedLong:value]];
}

- (void)nx_replaceLongLongAtIndex:(NSUInteger)index withLongLong:(long long)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithLongLong:value]];
}

- (void)nx_replaceUnsignedLongLongAtIndex:(NSUInteger)index withUnsignedLongLong:(unsigned long long)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedLongLong:value]];
}

- (void)nx_replaceFloatAtIndex:(NSUInteger)index withFloat:(float)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithFloat:value]];
}

- (void)nx_replaceDoubleAtIndex:(NSUInteger)index withDouble:(double)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithDouble:value]];
}

- (void)nx_replaceBoolAtIndex:(NSUInteger)index withBool:(BOOL)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithBool:value]];
}

- (void)nx_replaceIntegerAtIndex:(NSUInteger)index withInteger:(NSInteger)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithInteger:value]];
}

- (void)nx_replaceUnsignedIntegerAtIndex:(NSUInteger)index withUnsignedInteger:(NSUInteger)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedInteger:value]];
}

- (void)nx_replacePointValueAtIndex:(NSUInteger)index withPointValue:(CGPoint)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGPoint:value]];
}

- (void)nx_replaceSizeValueAtIndex:(NSUInteger)index withSizeValue:(CGSize)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGSize:value]];
}

- (void)nx_replaceRectValueAtIndex:(NSUInteger)index withRectValue:(CGRect)value
{
    [self nx_replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGRect:value]];
}

- (void)nx_removeObjectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        NSLog(@"%@ removeObjectAtIndexCheck: index 不在范围",self);
        return;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)nx_removeObjectsInRange:(NSRange)range{
    if(range.location == NSNotFound || !range.length){
        NSLog(@"范围不存在");
        return;
    }
    if(range.location + range.length > [self count]){
        NSLog(@"超出范围");
        return;
    }
    [self removeObjectsInRange:range];
}
- (void)nx_removeObject:(id)anObject{
    if(!anObject){
        NSLog(@"要删除的元素不存在");
        return;
    }
    [self removeObject:anObject];
}

- (void)nx_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes{
    if(!objects.count){
        NSLog(@"数据不存在");
        return;
    }
    [self insertObjects:objects atIndexes:indexes];
}

- (long)findFirstWithFilter:(BOOL (^)(id _Nullable value))block {
    for (int i=0; i<self.count; i++) {
        id item = self[i];
        if (block(item)) {
            return i;
        }
    }
    return NSNotFound;
}
@end
