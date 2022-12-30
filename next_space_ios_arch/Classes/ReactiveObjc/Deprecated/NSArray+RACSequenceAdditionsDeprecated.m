//
//  NSArray+NNN.m
//  next_space_ios_arch
//  废弃这个api
//  Created by XXF on 2022/12/30.
//

#import "NSArray+RACSequenceAdditionsDeprecated.h"
#import <ReactiveObjC/RACArraySequence.h>
@implementation NSArray(RACSequenceAdditionsDeprecated)

- (RACSequence *)rac_sequence DEPRECATED_MSG_ATTRIBUTE("性能不佳废弃了 多次copy 项目已经有替换方式了 请联系XXF") {
    return [RACArraySequence sequenceWithArray:self offset:0];
}

@end
