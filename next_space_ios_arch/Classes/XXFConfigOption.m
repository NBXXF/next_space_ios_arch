//
//  XXFConfigOption.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/8/24.
//

#import "XXFConfigOption.h"

@implementation XXFConfigOption

/**
 是否允许访问堆栈 (仅debug生效)
 */
- (BOOL)allowCallStackSymbols{
#if DEBUG
    return _allowCallStackSymbols;
#endif
    return NO;
}
@end
