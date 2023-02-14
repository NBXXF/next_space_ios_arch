//
//  NSObject+Describe.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import "NSObject+NXTools.h"

@implementation NSObject(NXTools)

- (NSString *)simpleDescription{
    return [NSString stringWithFormat:@"%@_%p",self.class,self];
}


+ (instancetype)toKindOfClassObjectFrom:(NSObject *)fromObject{
    if([fromObject isKindOfClass:self]){
        return fromObject;
    }
    @throw [NSException exceptionWithName:@"转换失败" reason:[NSString stringWithFormat:@"%@_is not KindOfClass:%@",fromObject,self] userInfo:nil];
}

/**
 转换成当前类的类型 本质 isKindOfClass,转换不成功返回nil
 */
+ (nullable instancetype)toKindOfClassObjectOrNilFrom:(NSObject *)fromObject{
    if([fromObject isKindOfClass:self]){
        return fromObject;
    }
    return nil;
}

/**
 转换成当前类的类型 本质 isMemberOfClass,转换不成功会报错
 */
+ (instancetype)toMemberOfClassObjectFrom:(NSObject *)fromObject{
    if([fromObject isMemberOfClass:self]){
        return fromObject;
    }
    @throw [NSException exceptionWithName:@"转换失败" reason:[NSString stringWithFormat:@"%@_is not MemberOfClass:%@",fromObject,self] userInfo:nil];
}

/**
 转换成当前类的类型 本质 isMemberOfClass,转换不成功返回nil
 */
+ (nullable instancetype)toMemberOfClassObjectOrNilFrom:(NSObject *)fromObject{
    if([fromObject isMemberOfClass:self]){
        return fromObject;
    }
    return nil;
}


- (instancetype)applyWithBlock:(void (^)(id _Nonnull))block{
    block(self);
    return self;
}

- (id)mapWithBlock:(id  _Nonnull (^)(id _Nonnull))block DEPRECATED_MSG_ATTRIBUTE("请使用mapReplaceWithBlock"){
    return block(self);
}

- (id)mapReplaceWithBlock:(id  _Nonnull (^)(id _Nonnull))block{
    return block(self);
}
@end
