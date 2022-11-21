//
//  Masonry+NXExtend.m
//  AFNetworking
//  增强约束,便于获取自己和父容器,便于很多业务相对父容器进行约束
//  Created by xxf on 2022/11/21.
//

#import "MAS_VIEW+NXExtend.h"

@implementation MAS_VIEW(NXExtend)
- (NSArray *)mas_makeConstraintsWithSelf:(void (^)(MASConstraintMaker * _Nonnull, __kindof UIView * _Nonnull, UIView * _Nonnull))block{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
    block(constraintMaker,self,self.superview);
    return [constraintMaker install];
}


- (NSArray *)mas_updateConstraintsWithSelf:(void (^)(MASConstraintMaker * _Nonnull, __kindof UIView * _Nonnull, UIView * _Nonnull))block{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker,self,self.superview);
    return [constraintMaker install];
}


- (NSArray *)mas_remakeConstraintsWithSelf:(void (^)(MASConstraintMaker * _Nonnull, __kindof UIView * _Nonnull, UIView * _Nonnull))block{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker,self,self.superview);
    return [constraintMaker install];
}

@end
