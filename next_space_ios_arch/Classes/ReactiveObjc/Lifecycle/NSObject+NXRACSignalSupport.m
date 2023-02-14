//
//  NSObject+NXRACSignalSupport.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import "NSObject+NXRACSignalSupport.h"

@implementation NSObject(NXRACSignalSupport)

- (RACSignal<RACUnit *> *)untilDeallocSignal{
    return [self rac_willDeallocSignal];
}
@end
