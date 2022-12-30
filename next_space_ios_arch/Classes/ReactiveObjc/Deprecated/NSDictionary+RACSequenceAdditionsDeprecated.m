//
//  NSDictionary+RACSequenceAdditionsDeprecated.m
//  next_space_ios_arch
//  废弃这个api
//  Created by XXF on 2022/12/30.
//

#import "NSDictionary+RACSequenceAdditionsDeprecated.h"
#import "NSDictionary+RACSequenceAdditions.h"
#import "NSArray+RACSequenceAdditions.h"
#import "RACSequence.h"
#import "RACTuple.h"

@implementation NSDictionary (RACSequenceAdditionsDeprecated)

- (RACSequence *)rac_sequence DEPRECATED_MSG_ATTRIBUTE("性能不佳废弃了 多次copy 项目已经有替换方式了 请联系XXF"){
    NSDictionary *immutableDict = [self copy];

    // TODO: First class support for dictionary sequences.
    return [immutableDict.allKeys.rac_sequence map:^(id key) {
        id value = immutableDict[key];
        return RACTuplePack(key, value);
    }];
}

- (RACSequence *)rac_keySequence DEPRECATED_MSG_ATTRIBUTE("性能不佳废弃了 多次copy 项目已经有替换方式了 请联系XXF") {
    return self.allKeys.rac_sequence;
}

- (RACSequence *)rac_valueSequence DEPRECATED_MSG_ATTRIBUTE("性能不佳废弃了 多次copy 项目已经有替换方式了 请联系XXF") {
    return self.allValues.rac_sequence;
}

@end
