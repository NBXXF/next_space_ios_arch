//
//  NSBundle+NXTools.m
//  next_space_ios_arch
//
//  Created by XXF on 2023/3/10.
//

#import "NSBundle+NXTools.h"
#import <next_space_ios_arch/ThreadUtils.h>

@implementation NSBundle(NXTools)

- (NSString *)pathForResource:(NSString *)fileName{
    return [self pathForResourceWithFileName:fileName];
}

- (NSString *)pathForResourceWithFileName:(NSString *)fileName{
    assertAtSubThread();
    NSString *path = [self pathForResource:fileName ofType:@""];
    return path;
}

- (NSString *)stringForResource:(NSString *)fileName{
    NSString *path = [self pathForResourceWithFileName:fileName];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    return str;
}

- (NSData *)dataForResource:(NSString *)fileName{
    NSString *path = [self pathForResourceWithFileName:fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

@end
