//
//  NSObject+Describe.m
//  next_space_ios_arch
//
//  Created by XXF on 2022/10/27.
//

#import "NSObject+Describe.h"

@implementation NSObject(Describe)

- (NSString *)simpleDescription{
    return [NSString stringWithFormat:@"%@_%p",self.class,self];
}
@end
