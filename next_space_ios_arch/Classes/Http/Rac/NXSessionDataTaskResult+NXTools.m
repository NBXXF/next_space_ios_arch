//
//  NXSessionDataTaskResult+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/5/24.
//

#import "NXSessionDataTaskResult+NXTools.h"
#import <next_space_ios_arch/NXHTTPSessionManager+RACSingal.h>

@implementation NXSessionDataTaskResult(NXTools)
- (BOOL)isJSON{
    return [self.responseObject isKindOfClass:NSDictionary.class]||[self.responseObject isKindOfClass:NSArray.class];
}

- (BOOL)isBinary{
    return [self.responseObject isKindOfClass:NSData.class];
}

- (BOOL)isCache{
    return [[self.userInfo objectForKey:NXNetworkingTaskResponseIsCacheKey] boolValue];
}
@end
