//
//  NSDictionary+RACSequenceAdditionsDeprecated.h
//  next_space_ios_arch
//  废弃这个api
//  Created by XXF on 2022/12/30.
//

#import <UIKit/UIKit.h>


@class RACSequence<__covariant ValueType>;
@class RACTwoTuple<__covariant First, __covariant Second>;

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (RACSequenceAdditionsDeprecated)

/// Creates and returns a sequence of key/value tuples.
///
/// Mutating the receiver will not affect the sequence after it's been created.
@property (nonatomic, copy, readonly) RACSequence<RACTwoTuple<KeyType, ObjectType> *> *rac_sequence DEPRECATED_MSG_ATTRIBUTE("性能不佳废弃了 多次copy 项目已经有替换方式了 请联系XXF");

/// Creates and returns a sequence corresponding to the keys in the receiver.
///
/// Mutating the receiver will not affect the sequence after it's been created.
@property (nonatomic, copy, readonly) RACSequence<KeyType> *rac_keySequence DEPRECATED_MSG_ATTRIBUTE("性能不佳废弃了 多次copy 项目已经有替换方式了 请联系XXF");

/// Creates and returns a sequence corresponding to the values in the receiver.
///
/// Mutating the receiver will not affect the sequence after it's been created.
@property (nonatomic, copy, readonly) RACSequence<ObjectType> *rac_valueSequence DEPRECATED_MSG_ATTRIBUTE("性能不佳废弃了 多次copy 项目已经有替换方式了 请联系XXF");

@end

NS_ASSUME_NONNULL_END

