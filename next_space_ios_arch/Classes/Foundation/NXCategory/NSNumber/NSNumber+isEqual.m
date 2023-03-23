//
//  NSNumber+isEqual.m
//  AppArch
//
//  Created by jsonLee on 2022/9/19.
//

#import "NSNumber+isEqual.h"
#import <next_space_ios_arch/NSObject+Swizzling.h>
@implementation NSNumber (isEqual)
+ (void)load{
    [NSObject nx_swizzleInstanceMethodWithClass:self originalSelector:@selector(isEqualToNumber:) swizzledSelector:@selector(nx_isEqualToNumber:)];
}

- (BOOL)nx_isEqualToNumber:(NSNumber *)number{
    if(!number){
        return NO;
    }
    return [self nx_isEqualToNumber:number];
}
@end
