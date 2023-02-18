//
//  NSURL+NXUtil.m
//  NX
//
//  Created by hedeyong on 2021/06/20.
//  Copyright © 2021年 NextSpace. All rights reserved.
//

#import "NSURL+NXUtil.h"
#import "NSString+NXUtil.h"
#import "NSArray+NXUtil.h"
#import <malloc/malloc.h>
#import "NSDictionary+NXUtil.h"
@implementation NSURL (NXUtil)

+ (BOOL)nx_isEmpty:(NSURL *)object
{
    BOOL result = YES;
    if (object != nil && [object isKindOfClass:[NSURL class]]) {
        result = NO;
    }
    return result;
}

+ (nullable instancetype)nx_URLWithStringCheck:(NSString * _Nonnull)URLString
{
    if (!URLString || URLString.length == 0) {
        return nil;
    }
    return [NSURL URLWithString:URLString];
}

+ (nullable instancetype)nx_URLWithStringCheck:(NSString * _Nonnull)URLString relativeToURL:(nullable NSURL *)baseURL
{
    if (!URLString || URLString.length == 0) {
        return nil;
    }
    return [NSURL URLWithString:URLString relativeToURL:baseURL];
}

- (NSDictionary * _Nullable)nx_arguments
{
    NSMutableDictionary *parameters = nil;
    NSString *query = [self query];
    if (!query || query.length == 0) {
        parameters = [NSMutableDictionary new];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
        NSScanner *scanner = [[NSScanner alloc] initWithString:query];
        while (![scanner isAtEnd]) {
            NSString *pairString = nil;
            [scanner scanUpToCharactersFromSet:characterSet intoString:&pairString];
            [scanner scanCharactersFromSet:characterSet intoString:NULL];
            NSArray *rows = [pairString componentsSeparatedByString:@"="];
            if (rows != nil && [rows count] == 2) {
                NSString *key = [rows nx_stringAtIndex:0];
                NSString *value = [[rows nx_stringAtIndex:1] nx_stringByUrlDecode];
                if ([value hasPrefix:@"0x"]) {
                    @try {
                        id obj = [NSURL nx_addressToObj:value];
                        if (obj) {
                            [parameters nx_setObjectCheck:obj forKey:key];
                        } else {
                            [parameters nx_setObjectCheck:@(YES) forKey:UrlGetArgumentsOccurError];
                        }
                    } @catch (NSException* exception) {
                        [parameters nx_setObjectCheck:@(YES) forKey:UrlGetArgumentsOccurError];
                    }
                } else {
                    [parameters nx_setObjectCheck:value forKey:key];
                }
            }
        }
    }
    return parameters;
}

+ (id)nx_addressToObj:(NSString *)address
{
    if (![address hasPrefix:@"0x"]) return nil;
    
    Class cls = nil;
    
    NSArray *arr = [address componentsSeparatedByString:@"__objCls__"];
    if (arr.count > 2) return nil;
    
    if (arr.count == 2) {
        cls = NSClassFromString([arr nx_objectAtIndexCheck:1]);
    }
    
    unsigned long long hex = strtoull(address.UTF8String, NULL, 0);
    size_t size = malloc_size((const void *)hex);
    if (size >= 16) {
        id obj = (__bridge id)(void *)hex;
        if (cls) {
            if ([obj isKindOfClass:cls]) return obj;
            return nil;
        }
        return obj;
    }
    return nil;
}

@end
