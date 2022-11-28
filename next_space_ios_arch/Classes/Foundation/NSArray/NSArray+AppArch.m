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
    __block NSUInteger find=NSNotFound;
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(block(obj)){
            find=idx;
            *stop=YES;
        }
    }];
    return find;
}

- (BOOL)containsObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    return [self indexOfObjectWithBlock:block]!=NSNotFound;
}

- (BOOL)allObjectEqualWithBlock:(BOOL (^)(id _Nonnull, id _Nonnull))block{
    if(self.count<=1){
        return YES;
    }
    __block id first=self.firstObject;
    __block BOOL allEqual=YES;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(!block(first,obj)){
            allEqual=NO;
            *stop=YES;
        }
    }];
    return allEqual;
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

- (NSMutableArray *)removeFirstObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    NSMutableArray *array=[NSMutableArray arrayWithArray:self];
    __block NSUInteger removeIndex=NSNotFound;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(block(obj)){
            removeIndex=idx;
            *stop=YES;
        }
    }];
    if(removeIndex!=NSNotFound){
        [array removeObjectAtIndex:removeIndex];
    }
    return array;
}

- (NSMutableArray *)removeObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    NSMutableArray *array=[NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(!block(obj)){
            [array addObject:obj];
        }
    }];
    return array;
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
