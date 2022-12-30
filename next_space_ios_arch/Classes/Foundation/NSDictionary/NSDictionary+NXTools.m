//
//  NSDictionary+NXTools.m
//  AFNetworking
//
//  Created by XXF on 2022/12/8.
//

#import "NSDictionary+NXTools.h"

@implementation NSDictionary(NXTools)
- (NSMutableDictionary *)filterObjectWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(block(key,obj)){
            [result setObject:obj forKey:key];
        }
    }];
    return result;
}

- (NSMutableDictionary *)mutableCopyOrCast{
    if([self isKindOfClass:NSMutableDictionary.class]){
        return (NSMutableDictionary *)self;
    }
    return self.mutableCopy;
}

- (NSDictionary *)copyOrCast{
    if([self isKindOfClass:NSDictionary.class]){
        return self;
    }
    return self.copy;
}
@end
