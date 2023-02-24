//
//  NXSessionDataTaskResult+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/2/24.
//

#import "NXSessionDataTaskResult+NXTools.h"

@implementation NXSessionDataTaskResult(NXTools)
- (BOOL)isJSON{
    return [self.responseObject isKindOfClass:NSDictionary.class]||[self.responseObject isKindOfClass:NSArray.class];
}

- (BOOL)isBinary{
    return [self isKindOfClass:NSData.class];
}
@end
