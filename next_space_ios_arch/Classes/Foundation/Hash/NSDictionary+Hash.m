//
//  NSDictionary+Safe.m
//  SafeObjectCrash
//
//  Created by lujh on 2018/4/18.
//  Copyright © 2018年 lujh. All rights reserved.
//

#import "NSDictionary+Hash.h"
#import "HashUtils.h"

@implementation NSDictionary (Hash)


- (NSUInteger)hash
{

    // Based upon standard hash algorithm ~ https://stackoverflow.com/a/4393493/337735
    NSUInteger result = 1;
    NSUInteger prime = KHashCodeConst;
    // Fast enumeration has an unstable ordering, so explicitly sort the keys
    // https://stackoverflow.com/a/8529761/337735
    for (id key in [[self allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        id value = [self objectForKey:key];
        // okay, so copying Java's hashCode a bit:
        // http://docs.oracle.com/javase/6/docs/api/java/util/Map.Entry.html#hashCode()
        result = prime * result + ([key hash] ^ [value hash]);
    }
    return result;
}


@end
