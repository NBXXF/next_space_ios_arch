//
//  UITableViewCell+NXRACSignalSupport.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import "UITableViewCell+NXRACSignalSupport.h"

@implementation UITableViewCell(NXRACSignalSupport)

- (RACSignal<RACUnit *> *)untilDeallocOrReuseSignal{
    return [self.rac_willDeallocSignal merge:self.rac_prepareForReuseSignal];
}

- (RACSignal<RACUnit *> *)untilReuseOrDeallocSignal{
    return [self.rac_prepareForReuseSignal merge:self.rac_willDeallocSignal];
}
@end
