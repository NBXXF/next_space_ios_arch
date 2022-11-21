//
//  Masonry+NXExtend.h
//  XXF
//  增强约束,便于获取自己和父容器,便于很多业务相对父容器进行约束
//  Created by xxf on 2022/11/21.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAS_VIEW(NXExtend)

- (NSArray *)mas_makeConstraintsWithSelf:(void(^)(MASConstraintMaker *make,__kindof UIView *it,UIView *superview))block;

- (NSArray *)mas_updateConstraintsWithSelf:(void(^)(MASConstraintMaker *make,__kindof UIView *it,UIView *superview))block;

- (NSArray *)mas_remakeConstraintsWithSelf:(void(^)(MASConstraintMaker *make,__kindof UIView *it,UIView *superview))block;
@end

NS_ASSUME_NONNULL_END
