//
//  Masonry+NXExtend.m
//  AFNetworking
//  增强约束,便于获取自己和父容器,便于很多业务相对父容器进行约束
//  Created by xxf on 2022/11/21.
//

#import "MAS_VIEW+NXExtend.h"

@implementation MAS_VIEW(NXExtend)
- (NSArray *)mas_makeConstraintsWithSelf:(void (^)(MASConstraintMaker * _Nonnull, __kindof UIView * _Nonnull, UIView * _Nonnull))block{
    UIView *superView=self.superview;
    NSAssert(superView, @"没有添加到容器里面");
    @try {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
        block(constraintMaker,self,superView);
        return [constraintMaker install];
    } @catch (NSException *exception) {
        NSString *errrorStr=[NSString stringWithFormat:@"约束异常:%@",exception];
        NSAssert(NO, errrorStr);
    }
    return [NSArray array];
}


- (NSArray *)mas_updateConstraintsWithSelf:(void (^)(MASConstraintMaker * _Nonnull, __kindof UIView * _Nonnull, UIView * _Nonnull))block{
    UIView *superView=self.superview;
    NSAssert(superView, @"没有添加到容器里面");
    @try {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
        constraintMaker.updateExisting = YES;
        block(constraintMaker,self,superView);
        return [constraintMaker install];
    } @catch (NSException *exception) {
        NSString *errrorStr=[NSString stringWithFormat:@"约束异常:%@",exception];
        NSAssert(NO, errrorStr);
    }
    return [NSArray array];
}


- (NSArray *)mas_remakeConstraintsWithSelf:(void (^)(MASConstraintMaker * _Nonnull, __kindof UIView * _Nonnull, UIView * _Nonnull))block{
    UIView *superView=self.superview;
    NSAssert(superView, @"没有添加到容器里面");
    @try {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];
        constraintMaker.removeExisting = YES;
        block(constraintMaker,self,superView);
        return [constraintMaker install];
    } @catch (NSException *exception) {
        NSString *errrorStr=[NSString stringWithFormat:@"约束异常:%@",exception];
        NSAssert(NO, errrorStr);
    }
    return [NSArray array];
}

@end
