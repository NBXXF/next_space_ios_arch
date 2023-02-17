//
//  NSDictionary+NXTools.m
//  AFNetworking
//
//  Created by XXF on 2022/12/8.
//

#import "NSDictionary+NXTools.h"

@implementation NSDictionary(NXTools)

- (instancetype)applyWithBlock:(void (^)(NSDictionary * _Nonnull))block{
    block(self);
    return self;
}

- (NSMutableDictionary *)filterObjectWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(block(key,obj)){
            [result setObject:obj forKey:key];
        }
    }];
    return result;
}

- (RACTwoTuple *)firstObjectWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    __block RACTwoTuple *find=nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(block(key,obj)){
            find=[RACTwoTuple pack:key :obj];
            *stop=YES;
        }
    }];
    return find;
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
