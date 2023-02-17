//
//  NSSet+NXTools.m
//  AFNetworking
//
//  Created by XXF on 2023/2/17.
//

#import "NSSet+NXTools.h"


@implementation NSSet(NXTools)

- (NSMutableArray *)filterObjectWithBlock:(BOOL (^)(id _Nonnull))block{
    NSMutableArray *find=[NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        if(block(obj)){
            [find addObject:obj];
        }
    }];
    return find;
}


@end
