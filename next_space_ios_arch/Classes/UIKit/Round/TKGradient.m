//
//  TKGradient.m
//  AFNetworking
//
//  Created by 1234 on 2022/11/21.
//

#import "TKGradient.h"

@implementation TKGradient
//万能初始化方法
- (instancetype)initWithBlock: (void (^)(__kindof TKGradient * _Nonnull it))block{
    self=[super init];
    if(self){
        block(self);
    }
    return self;
}

@end
