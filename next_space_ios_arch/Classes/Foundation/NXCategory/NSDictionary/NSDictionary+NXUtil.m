//
//  NSDictionary+NXUtil.m
//  NX
//
//  Created by hedeyong on 16/9/12.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import "NSDictionary+NXUtil.h"
#import "NSString+NXUtil.h"

@implementation NSDictionary (NXUtil)

+ (BOOL)nx_isEmpty:(NSDictionary *)object;
{
    BOOL result = YES;
    if (object != nil && [object isKindOfClass:[NSDictionary class]] && [object count] > 0) {
        result = NO;
    }
    return result;
}

+ (NSDictionary *)nx_dictionaryWithContentsOfData:(NSData *)data
{
    NSError *error = nil;
    NSPropertyListFormat format;
    NSDictionary *result = (NSDictionary*)[NSPropertyListSerialization
                                           propertyListWithData:data
                                           options:NSPropertyListMutableContainersAndLeaves
                                           format:&format error:&error];
    if ([result isKindOfClass:[NSDictionary class]]) {
        return result;
    }
    return nil;
}

- (id)nx_objectForKeyCheck:(id)aKey
{
    if (aKey == nil) {
        return nil;
    }
    
    id value = [self objectForKey:aKey];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)nx_objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass
{
    return [self nx_objectForKeyCheck:key class:aClass defaultValue:nil];
}

- (id)nx_objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    if (![value isKindOfClass:aClass]) {
        return defaultValue;
    }
    return value;
}

- (NSString *)nx_urlArgumentsValue
{
    NSMutableString *string = [NSMutableString new];
    for (NSString *key in self) {
        NSString *value = [self nx_stringForKey:key];
        if (string.length == 0) {
            [string appendFormat:@"%@=%@",key,[value nx_stringByUrlEncoding]];
        }
        else {
            [string appendFormat:@"&%@=%@",key,[value nx_stringByUrlEncoding]];
        }
    }
    return string;
}

- (NSArray *)nx_arrayForKey:(id)key
{
    return [self nx_arrayForKey:key defaultValue:nil];
}

- (NSArray *)nx_arrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
    return [self nx_objectForKeyCheck:key class:[NSArray class] defaultValue:defaultValue];
}

- (NSMutableArray *)nx_mutableArrayForKey:(id)key
{
    return [self nx_mutableArrayForKey:key defaultValue:nil];
}

- (NSMutableArray *)nx_mutableArrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
    return [self nx_objectForKeyCheck:key class:[NSMutableArray class] defaultValue:defaultValue];
}

- (NSDictionary *)nx_dictionaryForKey:(id)key
{
    return [self nx_dictionaryForKey:key defaultValue:nil];
}

- (NSDictionary *)nx_dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
    return [self nx_objectForKeyCheck:key class:[NSDictionary class] defaultValue:defaultValue];
}

- (NSMutableDictionary *)nx_mutableDictionaryForKey:(id)key
{
    return [self nx_mutableDictionaryForKey:key defaultValue:nil];
}

- (NSMutableDictionary *)nx_mutableDictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
    return [self nx_objectForKeyCheck:key class:[NSMutableDictionary class] defaultValue:defaultValue];
}

- (NSData *)nx_dataForKey:(id)key
{
    return [self nx_dataForKey:key defaultValue:nil];
}

- (NSData *)nx_dataForKey:(id)key defaultValue:(NSData *)defaultValue
{
    return [self nx_objectForKeyCheck:key class:[NSData class] defaultValue:defaultValue];
}

- (NSString *)nx_stringForKey:(id)key
{
    return [self nx_stringForKey:key defaultValue:nil];
}

- (NSString *)nx_stringForKeyToString:(id)key
{
    return [self nx_stringForKey:key defaultValue:@""];
}

- (NSString *)nx_stringForKeyToString:(id)key defaultValue:(NSString *)defaultValue
{
    NSString *value = [self nx_stringForKey:key defaultValue:@""];
    if (!value || value.length == 0) {
        value = defaultValue;
    }
    return value;
}

- (NSString *)nx_stringForKey:(id)key defaultValue:(NSString *)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    
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

- (NSNumber *)nx_numberForKey:(id)key
{
    return [self nx_numberForKey:key defaultValue:nil];
}

- (NSNumber *)nx_numberForKey:(id)key defaultValue:(NSNumber *)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    
    if ([value isKindOfClass:[NSString class]]) {
        return [value nx_numberValue];
    }
    
    if (![value isKindOfClass:[NSNumber class]]) {
        return defaultValue;
    }
    
    return value;
}

- (char)nx_charForKey:(id)key
{
    id value = [self nx_objectForKeyCheck:key];
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

- (unsigned char)nx_unsignedCharForKey:(id)key
{
    id value = [self nx_objectForKeyCheck:key];
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

- (short)nx_shortForKey:(id)key
{
    return [self nx_shortForKey:key defaultValue:0];
}

- (short)nx_shortForKey:(id)key defaultValue:(short)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (unsigned short)nx_unsignedShortForKey:(id)key
{
    return [self nx_unsignedShortForKey:key defaultValue:0];
}

- (unsigned short)nx_unsignedShortForKey:(id)key defaultValue:(unsigned short)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (int)nx_intForKey:(id)key
{
    return [self nx_intForKey:key defaultValue:0];
}

- (int)nx_intForKey:(id)key defaultValue:(int)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned int)nx_unsignedIntForKey:(id)key
{
    return [self nx_unsignedIntForKey:key defaultValue:0];
}

- (unsigned int)nx_unsignedIntForKey:(id)key defaultValue:(unsigned int)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (long)nx_longForKey:(id)key
{
    return [self nx_longForKey:key defaultValue:0];
}

- (long)nx_longForKey:(id)key defaultValue:(long)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (unsigned long)nx_unsignedLongForKey:(id)key
{
    return [self nx_unsignedLongForKey:key defaultValue:0];
}

- (unsigned long)nx_unsignedLongForKey:(id)key defaultValue:(unsigned long)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (long long)nx_longLongForKey:(id)key
{
    return [self nx_longLongForKey:key defaultValue:0];
}

- (long long)nx_longLongForKey:(id)key defaultValue:(long long)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long long)nx_unsignedLongLongForKey:(id)key
{
    return [self nx_unsignedLongLongForKey:key defaultValue:0];
}

- (unsigned long long)nx_unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (float)nx_floatForKey:(id)key
{
    return [self nx_floatForKey:key defaultValue:0.0];
}

- (float)nx_floatForKey:(id)key defaultValue:(float)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        float result = [value floatValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (double)nx_doubleForKey:(id)key
{
    return [self nx_doubleForKey:key defaultValue:0.0];
}

- (double)nx_doubleForKey:(id)key defaultValue:(double)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        double result = [value doubleValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}


- (BOOL)nx_boolForKey:(id)key
{
    return [self nx_boolForKey:key defaultValue:NO];
}

- (BOOL)nx_boolForKey:(id)key defaultValue:(BOOL)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    else {
        return defaultValue;
    }
}

- (NSInteger)nx_integerForKey:(id)key
{
    return [self nx_integerForKey:key defaultValue:0];
}

- (NSInteger)nx_integerForKey:(id)key defaultValue:(NSInteger)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    else {
        return defaultValue;
    }
}

- (NSUInteger)nx_unsignedIntegerForKey:(id)key
{
    return [self nx_unsignedIntegerForKey:key defaultValue:0];
}

- (NSUInteger)nx_unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (CGPoint)nx_pointForKey:(id)key
{
    return [self nx_pointForKey:key defaultValue:CGPointZero];
}

- (CGPoint)nx_pointForKey:(id)key defaultValue:(CGPoint)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (CGSize)nx_sizeForKey:(id)key
{
    return [self nx_sizeForKey:key defaultValue:CGSizeZero];
}

- (CGSize)nx_sizeForKey:(id)key defaultValue:(CGSize)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

- (CGRect)nx_rectForKey:(id)key
{
    return [self nx_rectForKey:key defaultValue:CGRectZero];
}

- (CGRect)nx_rectForKey:(id)key defaultValue:(CGRect)defaultValue
{
    id value = [self nx_objectForKeyCheck:key];
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

/// 设置值
/// @param value 值
/// @param aKey key
- (NSMutableDictionary *)nx_becomMutableSetObject:(id)value forKey:(id)aKey{
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:self];
    [mdict nx_setObjectCheck:value forKey:aKey];
    return mdict;
}

@end

@implementation NSMutableDictionary (NXUtil)

- (void)nx_setObjectCheckWithDefaultValue:(id)anObject forKey:(id <NSCopying>)aKey {
    if (aKey == nil) {
        NSLog(@"%@ nx_setObjectCheckWithDefaultValue: aKey 为 nil",self);
        return;
    }
    
    if (anObject == nil) {
        NSLog(@"%@ nx_setObjectCheckWithDefaultValue: anObject 为 nil",self);
        anObject = @"";
        //return;
    }
    [self setObject:anObject forKey:aKey];
}

- (void)nx_setObjectCheck:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (aKey == nil) {
        NSLog(@"%@ setObjectCheck: aKey 为 nil",self);
        return;
    }
        
    if (anObject == nil) {
        NSLog(@"%@ setObjectCheck: anObject 为 nil",self);
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

- (void)nx_setChar:(char)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithChar:value] forKey:key];
}

- (void)nx_setUnsignedChar:(unsigned char)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithUnsignedChar:value] forKey:key];
}

- (void)nx_setShort:(short)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithShort:value] forKey:key];
}

- (void)nx_setUnsignedShort:(unsigned short)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithUnsignedShort:value] forKey:key];
}

- (void)nx_setInt:(int)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithInt:value] forKey:key];
}

- (void)nx_setUnsignedInt:(unsigned int)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithUnsignedInt:value] forKey:key];
}

- (void)nx_setLong:(long)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithLong:value] forKey:key];
}

- (void)nx_setUnsignedLong:(unsigned long)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithUnsignedLong:value] forKey:key];
}

- (void)nx_setLongLong:(long long)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithLongLong:value] forKey:key];
}

- (void)nx_setUnsignedLongLong:(unsigned long long)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithUnsignedLongLong:value] forKey:key];
}

- (void)nx_setFloat:(float)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithFloat:value] forKey:key];
}

- (void)nx_setDouble:(double)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithDouble:value] forKey:key];
}

- (void)nx_setBool:(BOOL)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithBool:value] forKey:key];
}

- (void)nx_setInteger:(NSInteger)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithInteger:value] forKey:key];
}

- (void)nx_setUnsignedInteger:(NSUInteger)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSNumber numberWithUnsignedInteger:value] forKey:key];
}

- (void)nx_setPointValue:(CGPoint)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSValue valueWithCGPoint:value] forKey:key];
}

- (void)nx_setSizeValue:(CGSize)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSValue valueWithCGSize:value] forKey:key];
}

- (void)nx_setRectValue:(CGRect)value forKey:(id<NSCopying>)key
{
    [self nx_setObjectCheck:[NSValue valueWithCGRect:value] forKey:key];
}

- (void)nx_removeObjectForKeyCheck:(id)aKey
{
    if (aKey == nil) {
        NSLog(@"%@ removeObjectForKeyCheck: aKey 为 nil",self);
        return;
    }
    
    [self removeObjectForKey:aKey];
}

- (void)nx_addAll:(NSDictionary *)dictionary {
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self nx_setObjectCheck:obj forKey:key];
    }];
}


@end
