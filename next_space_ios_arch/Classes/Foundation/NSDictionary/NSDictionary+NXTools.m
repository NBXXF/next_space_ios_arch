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

- (NSMutableDictionary *)mapEachWithBlock:(RACTwoTuple * _Nonnull (^)(id _Nonnull, id _Nonnull))block{
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        RACTwoTuple *convert= block(key,obj);
        if(convert){
            [result setObject:convert.second forKey:convert.first];
        }
    }];
    return result;
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

- (NSMutableArray *)filterKeyWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    NSMutableArray *result=[NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(block(key,obj)){
            [result addObject:key];
        }
    }];
    return result;
}

- (NSMutableArray *)filterValueWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    NSMutableArray *result=[NSMutableArray array];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(block(key,obj)){
            [result addObject:obj];
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

- (id)firstKeyWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    return [self firstObjectWithBlock:block].first;
}

- (id)firstValueWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    return [self firstObjectWithBlock:block].second;
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
