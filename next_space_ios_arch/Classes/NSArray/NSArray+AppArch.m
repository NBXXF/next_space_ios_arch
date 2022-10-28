//
//  NSArray+AppArch.m
//  JLRoutes
//
//  Created by XXF on 2022/10/28.
//

#import "NSArray+AppArch.h"

@implementation NSArray(AppArch)


- (NSMutableArray *)mapObjectWithBlock:(id  _Nonnull (^)(id _Nonnull))block{
    NSMutableArray *find=[NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [find addObject:block(obj)];
    }];
    return find;
}

- (id)firstObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    __block id find=nil;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(block(obj)){
            find=obj;
            *stop=YES;
        }
    }];
    return find;
}

- (id)lastObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    __block id find=nil;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(block(obj)){
            find=obj;
            *stop=YES;
        }
    }];
    return find;
}

- (NSUInteger)indexOfObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    __block NSInteger find=-1;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(block(obj)){
            find=idx;
            *stop=YES;
        }
    }];
    return find;
}

- (NSMutableArray *)filterObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    NSMutableArray *find=[NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(block(obj)){
            [find addObject:obj];
        }
    }];
    return find;
}

- (NSMutableDictionary *)associateObjectBy:(id  _Nonnull (^)(id _Nonnull))keyBlock{
    NSMutableDictionary *find=[NSMutableDictionary dictionary];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [find setObject:obj forKey:keyBlock(obj)];
    }];
    return find;
}

- (NSMutableDictionary<id,id> *)associateObjectBy:(id  _Nonnull (^)(id _Nonnull))keyBlock valueBlock:(id  _Nonnull (^)(id _Nonnull))valueBlock{
    NSMutableDictionary *find=[NSMutableDictionary dictionary];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [find setObject:valueBlock(obj) forKey:keyBlock(obj)];
    }];
    return find;
}


@end
