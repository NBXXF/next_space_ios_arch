//
//  NSArray+AppArch.m
//  JLRoutes
//
//  Created by XXF on 2022/10/28.
//

#import "NSArray+AppArch.h"
#import <next_space_ios_arch/NSObject+NXTools.h>

@implementation NSArray(AppArch)

- (instancetype)applyWithBlock:(void (^)(NSArray * _Nonnull))block{
    block(self);
    return self;
}



- (NSMutableArray *)mapReplaceEachWithBlock:(id  _Nonnull (^)(id _Nonnull))block{
    NSMutableArray *find=[NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id result= block(obj);
        if(result){
            [find addObject:result];
        }
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
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    if(self.count<=0){
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



-(NSMutableArray *)mutableCopyOrCast{
    if([self isKindOfClass:NSMutableArray.class]){
        return (NSMutableArray *)self;
    }
    return self.mutableCopy;
}


-(NSArray *)copyOrCast{
    if([self isKindOfClass:NSArray.class]){
        return self;
    }
    return self.copy;
}

- (NSString *)componentsJoinedByString:(NSString *)separator objectMapBlock:(NSString * _Nonnull (^)(id _Nonnull))block{
    __block NSString *componentsStr=@"";
    __block NSUInteger arrayCount=self.count;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *result= [NSString toKindOfClassObjectOrNilFrom: block(obj)];
        if(result){
            componentsStr=[componentsStr stringByAppendingString:result];
            if(idx<arrayCount-1){
                componentsStr=[componentsStr stringByAppendingString:separator];
            }
        }
    }];
    return componentsStr;
}
@end
