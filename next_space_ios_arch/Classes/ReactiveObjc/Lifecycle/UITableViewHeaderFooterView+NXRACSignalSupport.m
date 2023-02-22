//
//  UITableViewHeaderFooterView+NXRACSignalSupport.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/14.
//

#import "UITableViewHeaderFooterView+NXRACSignalSupport.h"

@implementation UITableViewHeaderFooterView(NXRACSignalSupport)
- (RACSignal<RACUnit *> *)untilReuseSignal{
    return self.rac_prepareForReuseSignal;
}

- (RACSignal<RACUnit *> *)untilDeallocOrReuseSignal{
    return [self.rac_prepareForReuseSignal takeUntil:self.rac_willDeallocSignal];
}

- (RACSignal<RACUnit *> *)untilReuseOrDeallocSignal{
    return [self untilDeallocOrReuseSignal];
}
@end
