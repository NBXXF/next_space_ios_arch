//
//  NXTypeToken.m
//  next_space_ios_arch
//  用于描述json 解析的结构类型
//  Created by XXF on 2022/11/9.
//

#import "NXTypeToken.h"
#import <next_space_ios_arch/NSObject+NXTools.h>
@interface NXTypeToken()
@property(nonatomic,strong) Class classType;
@property(nonatomic,assign) BOOL isArray;
@end
@implementation NXTypeToken

+ (NXTypeToken * _Nonnull (^)(Class  _Nonnull __unsafe_unretained))arrayTypeToken{
    return ^NXTypeToken *(Class classType){
        return [[NXTypeToken alloc] initByBlock:^(NXTypeToken *_Nonnull it) {
            it.classType=classType;
            it.isArray=YES;
        }];
    };
}

+ (NXTypeToken * _Nonnull (^)(Class  _Nonnull __unsafe_unretained))objectTypeToken{
    return ^NXTypeToken *(Class classType){
        return [[NXTypeToken alloc] initByBlock:^(NXTypeToken *_Nonnull it) {
            it.classType=classType;
            it.isArray=NO;
        }];
    };
}
@end
